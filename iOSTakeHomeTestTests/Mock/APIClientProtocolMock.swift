//
//  APIClientProtocolMock.swift
//  iOSTakeHomeTestTests
//
//  Created by Shaza Hassan on 15/08/2024.
//

import Foundation
import MockingKit
@testable import iOSTakeHomeTest

class APIClientProtocolMock: Mock, APIClientProtocol {
        
    // Store the return values for generic methods
    var requestHttpMethodPathParametersBodyHeadersReturnValue: Any?
    var requestHttpCustomBaseUrlMethodPathParametersBodyHeadersReturnValue: Any?
    
    // Track method call parameters
    var requestHttpMethodPathParametersBodyHeadersReceived: (method: HTTPMethod, path: String, parameters: [String: Any]?, body: Data?, headers: [String: String])?
    var requestHttpCustomBaseUrlMethodPathParametersBodyHeadersReceived: (customBaseUrl: String, method: HTTPMethod, path: String, parameters: [String: Any]?, body: Data?, headers: [String: String])?
    
    func requestHttp<ResponseModel>(method: iOSTakeHomeTest.HTTPMethod, path: String, parameters: [String : Any]?, body: Data?, headers: [String : String]) async throws -> ResponseModel where ResponseModel : Decodable {
        requestHttpMethodPathParametersBodyHeadersReceived = (method, path, parameters, body, headers)
        if let value = requestHttpMethodPathParametersBodyHeadersReturnValue as? ResponseModel {
            return value
        }
        throw NSError(domain: "Mock Error", code: 1, userInfo: nil)
    }
    
    func requestHttp<ResponseModel>(customBaseUrl: String, method: iOSTakeHomeTest.HTTPMethod, path: String, parameters: [String : Any]?, body: Data?, headers: [String : String]) async throws -> ResponseModel where ResponseModel : Decodable {
        requestHttpCustomBaseUrlMethodPathParametersBodyHeadersReceived = (customBaseUrl, method, path, parameters, body, headers)
        if let value = requestHttpCustomBaseUrlMethodPathParametersBodyHeadersReturnValue as? ResponseModel {
            return value
        }
        throw NSError(domain: "Mock Error", code: 1, userInfo: nil)
    }
    
}
