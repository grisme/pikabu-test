//
//  PostDetailData.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

struct PostDetailData: Decodable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let likesCount: Int
    
    let text: String
    let images: [String]
}
