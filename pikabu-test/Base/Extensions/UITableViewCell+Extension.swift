//
//  UITableViewCell+Extension.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

extension UITableViewCell {

    class var reuseIdentifier: String {
        String(describing: self)
    }
    
}
