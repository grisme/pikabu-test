//
//  PostsResultData.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

struct PostsResultData: Decodable {
    let posts: [PostData]
    // ... possible additional data within posts request ...
}
