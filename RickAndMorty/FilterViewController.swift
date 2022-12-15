//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 15/12/22.
//

import UIKit

class FilterViewController: UITableViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var genderSegement: UISegmentedControl!
    @IBOutlet weak var statusSegment: UISegmentedControl!
    @IBOutlet weak var speciesPicker: UIPickerView!
    @IBOutlet weak var submitButton: UIButton!
    
    private lazy var speciesArray: [Species] = Species.allCases
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderSegement.selectedSegmentIndex = -1
        statusSegment.selectedSegmentIndex = -1
        self.speciesPicker.delegate = self
        self.speciesPicker.dataSource = self
    }
   
    
    @IBAction func submitTapped() {
        var filter = Dictionary<String, String>()
        let name = nameText.notNullText()
        if name.isNotEmpty {
            filter["name"] = name
        }
        print(filter)
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
        speciesArray[row].rawValue
    }
}
