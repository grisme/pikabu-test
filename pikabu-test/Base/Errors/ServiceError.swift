//
//  ServiceError.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation

// MARK: -  ServiceError error wrapper class implementation
final class ServiceError: Error {
    
    // MARK: Public properties
    public let code: Int
    public let text: String
    
    // MARK: Lifecycle
    init(code: Int, text: String) {
        self.code = code
        self.text = text
    }
    
    init(text: String) {
        self.code = 0
        self.text = text
    }
    
    convenience init(error: Error) {
        self.init(text: error.localizedDescription)
    }
}
