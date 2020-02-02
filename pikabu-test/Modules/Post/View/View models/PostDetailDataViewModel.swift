//
//  PostDetailDataViewModel.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 07.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

final class PostDetailDataViewModel {
    
    // MARK: Private properties
    private let postDetailData: PostDetailData
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    // MARK: View model getters
    var title: String {
        postDetailData.title
    }
    
    var likes: Int {
        postDetailData.likesCount
    }
    
    var date: Date {
        Date(timeIntervalSince1970: TimeInterval(postDetailData.timeshamp))
    }
    
    var dateString: String {
        dateFormatter.string(from: self.date)
    }
    
    var htmlText: String {
        var sourceString = postDetailData.text
        sourceString = sourceString.replacingOccurrences(of: "\n", with: "</br>")
        return sourceString
    }
    
    var plainText: String {
        // TODO: implement postDetailData.text plain processor (tags clearing, etc.)
        postDetailData.text
    }
    
    var imageURLs: [URL?] {
        postDetailData.images.map { stringURL -> URL? in
            URL(string: stringURL)
        }
    }
    
    // MARK: Initializers
    init(postDetailData: PostDetailData) {
        self.postDetailData = postDetailData
    }
}
