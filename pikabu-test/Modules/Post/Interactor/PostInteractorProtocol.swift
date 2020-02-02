//
//  PostInteractorProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import RxSwift

protocol PostInteractorProtocol: class {
    var postsService: PostsServiceProtocol? { get set }
    
    func obtainPost(postId: Int) -> Single<PostDetailData>?
}
