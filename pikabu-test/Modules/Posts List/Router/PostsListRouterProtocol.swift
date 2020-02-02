//
//  PostsListRouterProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

protocol PostsListRouterProtocol: class {
    var view: UIViewController? { get set }
    
    func openPost(postId: Int)
}
