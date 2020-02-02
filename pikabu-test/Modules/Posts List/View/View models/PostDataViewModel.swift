//
//  PostDataViewModel.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

final class PostDataViewModel {
    
    // MARK: Private properties
    private let postData: PostData
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    // MARK: View model getter properties
    var postId: Int {
        postData.postId
    }
    
    var title: String {
        postData.title
    }
    
    var previewText: String {
        postData.previewText
    }
    
    var likes: Int {
        postData.likesCount
    }
    
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(postData.timeshamp))
    }
    
    var dateString: String {
        dateFormatter.string(from: self.date)
    }
    
    var expanded: Bool = false
    
    // MARK: Initializers
    init(postData: PostData) {
        self.postData = postData
    }
}
