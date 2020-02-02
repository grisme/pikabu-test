//
//  PostsListTextManagerProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

protocol PostsListTextManagerProtocol: class {
    var title: String { get }
    var sortButton: String { get }
    var sortSelectorTitle: String { get }
    var sortSelectorMessage: String { get }
    var sortByLikes: String { get }
    var sortByDate: String { get }
    var errorTitle: String { get }
    var cancelButton: String { get }

    var obtainErrorText: String { get }
    var obtainRepeat: String { get }
}
