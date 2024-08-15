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
    
    func requestHttp<ResponseModel: Decodable>(
        customBaseUrl: String,
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]?,
        body: Data?,
        headers: [String: String]
    ) async throws -> ResponseModel    
}

class APIClient: APIClientProtocol {
    private let invalidUrlCode = 0 // Not an HTTP error
    private let baseUrlKey = "CFBundleShortVersionString"
    private let buildNumberKey = "CFBundleVersion"
    private var baseURL: String
    
    init(baseURL: String = "https://rickandmortyapi.com/api") {
        self.baseURL = baseURL
    }
    
    var version: String {
        let appVersion = Bundle.getString(key: baseUrlKey)
        let buildVersion = Bundle.getString(key: buildNumberKey)
        return "\(appVersion)(\(buildVersion))"
    }
    
    func requestHttp<ResponseModel: Decodable>(
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        body: Data?,
        headers: [String: String]
    ) async throws -> ResponseModel {
        let mergedHeaders = try await mergeWithHeaders(headers: headers)
        let request = try buildUrlRequest(
            url: baseURL,
            method: method,
            path: path,
            parameters: parameters,
            body: body,
            headers: mergedHeaders
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ResponseModel.self, from: data)
    }
    func requestHttp<ResponseModel: Decodable>(
        customBaseUrl: String,
        method: HTTPMethod,
        path: String,
        parameters: [String: Any]? = nil,
        body: Data?,
        headers: [String: String]
    ) async throws -> ResponseModel {
        let mergedHeaders = try await mergeWithHeaders(headers: headers)
        let request = try buildUrlRequest(
            url: customBaseUrl,
            method: method,
            path: path,
            parameters: parameters,
            body: body,
            headers: mergedHeaders
        )
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ResponseModel.self, from: data)
    }
    
    private func mergeWithHeaders(headers: [String: String]) async throws -> [String: String] {
        var mergedHeaders: [String: String] = [
            "Platform": "ios_customer",
            "Version": version,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        headers.forEach { mergedHeaders[$0.key] = $0.value }
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
        let urlString = url + (path.isEmpty ? "" : "/\(path)")
        let queryItemsString = try buildQueryItems(parameters: parameters, path: path)
        let fullUrlString = urlString + queryItemsString
        let fullUrl = try validateUrl(URL(string: fullUrlString))
        
        var request = URLRequest(url: fullUrl)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        return request
    }
    
    private func buildQueryItems(parameters: [String: Any]?, path: String) throws -> String {
        guard let params = parameters?.mapValues({ value -> Any in
            if let stringValue = value as? String {
                return stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            }
            return value
        }) else {
            return ""
        }
        
        let queryItems = params.map { "\($0)=\($1)" }.joined(separator: "&")
        return path.contains("?") ? "&\(queryItems)" : "?\(queryItems)"
    }
    
    private func validateUrl(_ url: URL?) throws -> URL {
        guard let url = url else {
            throw APIError(
                statusCode: invalidUrlCode,
                error: stringFromStatusCode(statusCode: invalidUrlCode),
                errorsCode: invalidUrlCode
            )
        }
        return url
    }
    
    private func stringFromStatusCode(statusCode: Int) -> String {
        return statusCode == invalidUrlCode ? "Invalid URL" : "Unknown Error"
    }
}

struct APIError: Error {
    let statusCode: Int
    let error: String
    let errorsCode: Int
}
