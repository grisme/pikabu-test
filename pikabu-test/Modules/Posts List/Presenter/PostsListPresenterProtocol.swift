//
//  PostsListPresenterProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

protocol PostsListPresenterProtocol: class {
    var view: PostsListViewProtocol? { get set }
    var interactor: PostsListInteractorProtocol? { get set }
    var router: PostsListRouterProtocol? { get set }
    var textManager: PostsListTextManagerProtocol? { get set }
    
    func viewDidLoad()
    func sortButtonPressed()
    func sortByLikesPressed()
    func sortByDatePressed()
    func postSelected(post: PostDataViewModel)
    
}
