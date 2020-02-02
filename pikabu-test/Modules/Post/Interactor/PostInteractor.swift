//
//  PostInteractor.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostInteractor implementation
final class PostInteractor {
    var postsService: PostsServiceProtocol?
}

// MARK: - PostInteractorProtocol implementation
extension PostInteractor: PostInteractorProtocol {
    func obtainPost(postId: Int) -> Single<PostDetailData>? {
        postsService?.obtainPost(with: postId)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .map { resultData in
                resultData.post
            }
    }
}
