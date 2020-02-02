//
//  PostsService.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PostsService implementation
final class PostsService {
    // MARK: Private properties
    private let sessionManager: SessionManagerProtocol
    private lazy var defaultDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: Lifecycle
    init() {
        sessionManager = SessionManager()
    }
    
    init(sessionManager: SessionManagerProtocol) {
        self.sessionManager = sessionManager
    }
}

// MARK: - PostsServiceProtocol implementation
extension PostsService: PostsServiceProtocol {
    
    func obtainPosts() -> Single<PostsResultData> {
        Single<PostsResultData>.create { [weak self] event -> Disposable in
            self?.sessionManager.makeRequest(method: .get, url: "posts.json", params: nil, success: { data in
                let decoder = self?.defaultDecoder ?? JSONDecoder()
                do {
                    let postsResult = try decoder.decode(PostsResultData.self, from: data)
                    event(.success(postsResult))
                } catch let exception {
                    event(.error(ServiceError(error: exception)))
                }
            }, failure: { serviceError in
                event(.error(serviceError))
            })
            return Disposables.create()
        }
    }
    
    func obtainPost(with postId: Int) -> Single<PostDetailResultData> {
        Single<PostDetailResultData>.create { [weak self] event -> Disposable in
            let targetURL = "\(postId).json"
            self?.sessionManager.makeRequest(method: .get, url: targetURL, params: nil, success: { data in
                let decoder = self?.defaultDecoder ?? JSONDecoder()
                do {
                    let postDetailResult = try decoder.decode(PostDetailResultData.self, from: data)
                    event(.success(postDetailResult))
                } catch let exception {
                    event(.error(ServiceError(error: exception)))
                }
            }, failure: { serviceError in
                event(.error(serviceError))
            })
            return Disposables.create()
        }
    }
}
