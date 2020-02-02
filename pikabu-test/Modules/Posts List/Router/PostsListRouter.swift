//
//  PostsListRouter.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

// MARK: - PostsListRouter implementation
final class PostsListRouter {
    // MARK: Injection properties
    weak var view: UIViewController?
}

// MARK: - PostsListRouterProtocol implementation
extension PostsListRouter: PostsListRouterProtocol {
    
    func openPost(postId: Int) {
        let postView = PostAssembly.assemble(postId: postId)
        view?.navigationController?.pushViewController(postView, animated: true)
    }
    
}
