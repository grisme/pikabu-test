//
//  PostViewProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

protocol PostViewProtocol: class {
    var presenter: PostPresenterProtocol? { get set }
    
    func showLoader()
    func hideLoader()
    func showPost(viewModel: PostDetailDataViewModel)
}
