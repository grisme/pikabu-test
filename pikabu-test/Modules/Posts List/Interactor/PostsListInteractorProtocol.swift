//
//  PostsListInteractorProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsListInteractorProtocol: class {
    var postsService: PostsServiceProtocol? { get set }
    
    func obtainPosts() -> Single<[PostData]>?
}
