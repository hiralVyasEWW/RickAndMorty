//
//  UIView.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 15/12/22.
//

import UIKit

extension UIView {
    func setCornerRadius(_ radious: CGFloat) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
    
    func clipToCircle() {
        self.setCornerRadius(frame.height/2)
    }
}

