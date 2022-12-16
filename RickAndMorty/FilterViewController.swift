//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 15/12/22.
//

import UIKit

protocol FilterDelegate {
    func filterCharacter(didSelectFilterOptions options: [URLQueryItem])
}

class FilterViewController: UITableViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var genderSegement: UISegmentedControl!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var speciesPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    var delegate: FilterDelegate?

    private lazy var speciesArray: [String] = ["All", "Human", "Alien"]
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderSegement.selectedSegmentIndex = -1
        statusSegment.selectedSegmentIndex = -1
        self.speciesPicker.delegate = self
        self.speciesPicker.dataSource = self
    }
   
    
    @IBAction func submitTapped() {
       // var filter = Dictionary<String, String>()
       
        let name = nameText.notNullText()

        var queryItemArray: [URLQueryItem] = []
        if name.isNotEmpty {
            queryItemArray.append(URLQueryItem(name: "name", value: name))
        }
        if genderSegement.selectedSegmentIndex > -1 {
            let gender = genderSegement.titleForSegment(at: genderSegement.selectedSegmentIndex)
            queryItemArray.append(URLQueryItem(name: "gender", value: gender))
            
        }
        if statusSegment.selectedSegmentIndex > -1 {
            let status = statusSegment.titleForSegment(at: statusSegment.selectedSegmentIndex)
            queryItemArray.append(URLQueryItem(name: "status", value: status))
        }
        let species = speciesArray[speciesPicker.selectedRow(inComponent: 0)]
        if species != "All" {
            queryItemArray.append(URLQueryItem(name: "species", value: species))
        }
        self.delegate?.filterCharacter(didSelectFilterOptions: queryItemArray)
        navigationController?.popViewController(animated: true)
       
    }
    
}

// MARK: - Pickerview methods
extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        speciesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        speciesArray[row]
    }
}
