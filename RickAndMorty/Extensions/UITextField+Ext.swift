//
//  UITextField+Ext.swift
//  RickAndMorty
//
//  Created by Hiral Vyas on 15/12/22.
//

import UIKit

extension UITextField {
    
    func notNullText() -> String {
        return self.text ?? ""
    }
    
}
