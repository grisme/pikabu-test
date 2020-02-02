//
//  PostAssembly.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

final class PostAssembly {
    
    class func assemble(postId: Int) -> UIViewController {
        let view = PostViewController(nibName: nil, bundle: nil)
        let presenter = PostPresenter()
        let interactor = PostInteractor()
        let router = PostRouter()
        let textManager = PostTextManager()
        let sessionManager = SessionManager()
        let postsService = PostsService(sessionManager: sessionManager)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.textManager = textManager
        presenter.postId = postId
        interactor.postsService = postsService
        router.view = view
        
        return view
    }
    
}
