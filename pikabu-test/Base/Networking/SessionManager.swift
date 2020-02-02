//
//  SessionManager.swift
//  pikabu-test
//
//  Created by Eugene Garifullin on 05.01.2020.
//  Copyright © 2020 Eugene Garifullin. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - SessionManager with SessionManagerProtocol implementation
class SessionManager: SessionManagerProtocol {
    
    // MARK: Private properties
    private var baseURL: String {
        // TODO: can be as really calculated property (different base URLs for debug and release mode, i.e.)
        "https://cs.pikabu.ru/files/api201910/"
    }

    private let queue = DispatchQueue(label: "pikabu-session-manager-queue", qos: .background)
    
    // MARK: SessionManagerProtocol methods
    func makeRequest(method: HTTPMethod,
                     url: String?,
                     params: [String : Any]?,
                     success: @escaping (_ data: Data) -> (),
                     failure: @escaping (_ error: ServiceError) -> ()) {
        
        let targetUrlString = baseURL + (url ?? "")
        guard let targetUrl = URL(string: targetUrlString) else { return }
        AF.request(targetUrl,
                   method: method,
                   parameters: params,
                   encoding: JSONEncoding.default)
            .responseJSON(queue: self.queue) { response in
                // Checking response error (network, OS, etc.)
                if let error = response.error {
                    failure(ServiceError(error: error))
                    return
                }
                
                // Response should contains JSON data
                guard let responseData = response.data else {
                    failure(ServiceError(text: "Invalid response data"))
                    return
                }
                
                // Calling up success handler
                success(responseData)
        }
    }
    
    
}
