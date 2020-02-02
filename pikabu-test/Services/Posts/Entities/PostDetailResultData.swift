//
//  PostDetailResultData.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

struct PostDetailResultData: Decodable {
    let post: PostDetailData
    // ... possible additional data within post with id request ...
}
