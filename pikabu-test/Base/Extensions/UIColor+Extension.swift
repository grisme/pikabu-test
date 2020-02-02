//
//  UIColor+Extension.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

extension UIColor {
    class var autoLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.label
        } else {
            return UIColor.black
        }
    }
    
    class var autoSecondaryLabel: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.gray
        }
    }
    
    class var autoBackground: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return UIColor.white
        }
    }
    
}
