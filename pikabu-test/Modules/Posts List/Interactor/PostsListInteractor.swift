//
//  PostsListInteractor.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostsListInteractor implementation
class PostsListInteractor {
    var postsService: PostsServiceProtocol?
}

// MARK: - PostsListInteractorProtocol implementation
extension PostsListInteractor: PostsListInteractorProtocol {
    
    func obtainPosts() -> Single<[PostData]>? {
        postsService?.obtainPosts()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .map { postsResultData in
                postsResultData.posts
            }
    }
}
