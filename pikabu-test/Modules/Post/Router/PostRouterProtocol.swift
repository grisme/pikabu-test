//
//  PostRouterProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

protocol PostRouterProtocol {
    var view: UIViewController? { get set }
    func openPostsList()
}
