//
//  PostPresenterProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

protocol PostPresenterProtocol: class {
    var postId: Int? { get set }
    var view: PostViewProtocol? { get set }
    var interactor: PostInteractorProtocol? { get set }
    var router: PostRouterProtocol? { get set }
    var textManager: PostTextManagerProtocol? { get set }
    func viewDidLoad()
}
