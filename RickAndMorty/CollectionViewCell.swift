//
//  CollectionViewCell.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 12/12/22.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    func setvalues(_ information : Information) {
        label.text = information.name
        let url = URL(string: information.image ?? "")
        imageview.kf.setImage(with: url)
        statusView.clipToCircle()
        statusView.backgroundColor = information.status?.color
        contentView.setCornerRadius(10)
    }
}
