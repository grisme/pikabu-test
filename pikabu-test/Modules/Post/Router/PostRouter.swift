//
//  PostRouter.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

// MARK: - PostRouter with PostRouterProtocol implementation
final class PostRouter: PostRouterProtocol {
    
    weak var view: UIViewController?
    
    func openPostsList() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}


