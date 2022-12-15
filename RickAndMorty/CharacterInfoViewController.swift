//
//  CharacterInfoViewController.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 13/12/22.
//

import UIKit
import Kingfisher

class CharacterInfoViewController: UIViewController {
    
    @IBOutlet weak var subview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    
    
    @IBOutlet weak var NLabel: UILabel!
    @IBOutlet weak var SLabel: UILabel!
    @IBOutlet weak var GLabel: UILabel!
    @IBOutlet weak var OLabel: UILabel!
    @IBOutlet weak var ELabel: UILabel!
    
    
    var characterInfo: Information?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Details"
        NLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        SLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        GLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        OLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        ELabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        configureViews()
        if let characterInfo = self.characterInfo {
            setvalues(characterInfo)
        }
    }
    
    private func configureViews() {
        imageview.setCornerRadius(20)
        subview.setCornerRadius(20)
        
    }
    
    private func setvalues(_ information: Information) {
        nameLabel.text = information.name
        statusLabel.text = information.status?.rawValue
        genderLabel.text = information.gender?.rawValue
        originLabel.text = information.origin?.name
        episodesLabel.text = "\(information.episode?.count ?? 0)"
        let url = URL(string: information.image ?? "")
        imageview.kf.setImage(with: url)
        
        
    }
    

}
