//
//  PostsServiceProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

protocol PostsServiceProtocol: class {
    init(sessionManager: SessionManagerProtocol)
    func obtainPosts() -> Single<PostsResultData>
    func obtainPost(with postId: Int) -> Single<PostDetailResultData>
}
