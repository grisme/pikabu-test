//
//  SessionManagerProtocol.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import Alamofire

protocol SessionManagerProtocol: class {
    func makeRequest(method: HTTPMethod,
                     url: String?,
                     params: [String: Any]?,
                     success: @escaping (_ response: Data) -> (),
                     failure: @escaping (_ error: ServiceError) -> ())
}
