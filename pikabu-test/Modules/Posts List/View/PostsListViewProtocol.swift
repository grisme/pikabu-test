//
//  PostsListViewProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 04.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

protocol PostsListViewProtocol: class {
    var presenter: PostsListPresenterProtocol? { get set }
    func showLoader()
    func hideLoader()
    func showError(text: String)
    func showButtonError(text: String, buttonTitle: String, buttonHandler: @escaping () -> ())
    func showPosts(posts: [PostDataViewModel])
    func showSortSelector()
}
