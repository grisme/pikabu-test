//
//  PostsListAssembly.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import UIKit

final class PostsListAssembly {
    
    public class func assemble() -> UIViewController {
        let view = PostsListViewController(nibName: nil, bundle: nil)
        let presenter = PostsListPresenter()
        let interactor = PostsListInteractor()
        let router = PostsListRouter()
        let textManager = PostsListTextManager()
        let sessionManager = SessionManager()
        let postsService = PostsService(sessionManager: sessionManager)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.textManager = textManager
        interactor.postsService = postsService
        router.view = view
        
        return view
    }
    
}
