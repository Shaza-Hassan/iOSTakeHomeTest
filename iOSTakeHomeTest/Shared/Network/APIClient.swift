//
//  APIClient.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 14/08/2024.
//

import Foundation

protocol APIClientProtocol {
    
    func requestHttp<ResponseModel: Decodable>(
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        body: Data?,
        headers: [String: String]
    ) async throws -> ResponseModel
    
    func setBaseUrl(url: String)
}
    

class APIClient : APIClientProtocol {
    fileprivate let invalidUrl = 0 // Not http error

    // your code -> version number
    private let appVersion = Bundle.getString(key: "CFBundleShortVersionString")
    // value for build number
    private let buildVersion = Bundle.getString(key: "CFBundleVersion")
    
    var version : String {
        return "\(appVersion)(\(buildVersion))"
    }
    
    var baseURL : String
    
    init(){
        baseURL = "https://rickandmortyapi.com/api"
    }
    
    init(baseURL: String){
        self.baseURL = baseURL
    }
    
    
    func setBaseUrl(url: String) {
        baseURL = url
    }
    
    func requestHttp<ResponseModel: Decodable>(
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        body: Data?,
        headers: [String: String]
    ) async throws -> ResponseModel {
        
        var mergedHeders: [String: String] = [:]
        mergedHeders = try await mergeWithHeaders(headers: headers)
        
        let request = try buildUrlRequest(
            url: baseURL,
            method: method,
            path: path,
            parameters: parameters,
            body: body,
            headers: mergedHeders
        )
        
        let (data, response) = try await URLSession.shared.data(for: request as URLRequest)
        ///decode json
        let responseModel = try JSONDecoder().decode(ResponseModel.self, from: data)
        return responseModel
    }
    
    private func mergeWithHeaders(headers: [String: String]) async throws -> [String: String] {
        var mergedHeaders: [String: String] = [:]
        
        mergedHeaders["Platform"] = "ios_customer"
        mergedHeaders["Version"] = version
        mergedHeaders["Accept"] = "application/json"
        mergedHeaders["Content-Type"] = "application/json"
        
        headers.forEach {
            mergedHeaders[$0.key] = $0.value
        }
        
        return mergedHeaders
    }
    
    private func buildUrlRequest(
        url: String,
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        body: Data?,
        headers: [String: String]
    ) throws -> URLRequest {
        let pathString = path.isEmpty ? "" : "/\(path)"
        let urlWithPathString = "\(url)\(pathString)"
        let queryItemsString: String
        
        let newParams : [String: Any]? = parameters?.mapValues{ (value) in
            if value is String {
                if #available(iOS 17.0, *) {
                    return value
                } else {
                    return (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                }
            }else {
                return value
            }
        }
        
        if path.contains("?") {
            queryItemsString =  newParams == nil ? "" : "&\(newParams!.map {"\($0)=\($1)"}.joined(separator: "&"))"
        } else {
            queryItemsString =  newParams == nil ? "" : "?\(newParams!.map {"\($0)=\($1)"}.joined(separator: "&"))"
        }
        let urlWithParametersString = "\(urlWithPathString)\(queryItemsString)"
        
        
        let fullUrl = try validateUrl(url: URL(string: urlWithParametersString))
        let request = NSMutableURLRequest(url: fullUrl)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }

    
    func validateUrl(url: URL?) throws -> URL {
        guard let url = url else {
            throw APIError(statusCode: invalidUrl,error: stringFromStatusCode(statusCode: invalidUrl), errorsCode: invalidUrl)
        }
        return url
    }
    
    func stringFromStatusCode(statusCode: Int) -> String {
        switch statusCode {
        case invalidUrl: return "Invalid URL"
        default: return "Unknown Error"
        }
    }
}

struct APIError: Error {
    let statusCode: Int
    let error: String
    let errorsCode: Int
}
