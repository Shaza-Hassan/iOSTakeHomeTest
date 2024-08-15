//
//  CharatersRepository.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 14/08/2024.
//

import Foundation

protocol CharactersGatway {
    
    func fetchCharacters(pagingModel: PagingModel<Character>,filterStatus:FilterStatus?) async throws ->PagingModel<Character>
}

class CharatersRepository : CharactersGatway {
    var apiService: APIClientProtocol
    
    init(apiService: APIClientProtocol) {
        self.apiService = apiService
    }
    
    func fetchCharacters(pagingModel: PagingModel<Character>,filterStatus:FilterStatus?) async throws ->PagingModel<Character> {
        var pagingModel = pagingModel
        
        if pagingModel.pagingStatus != .idle && pagingModel.canLoadMore {
            guard let url = pagingModel.info?.next else {
                throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            }
            
            let newPagingData: PagingModel<Character> = try await apiService.requestHttp(customBaseUrl:url ,method: .get, path: "", parameters: nil, body: nil, headers: [:])
            
            pagingModel.results.append(contentsOf: newPagingData.results)
            pagingModel.info = newPagingData.info
            pagingModel.pagingStatus = .loadedData
            return pagingModel
        }
        
        let path = "character"
        var params: [String: Any] = [:]
        
        if let filterStatus = filterStatus {
            params["status"] = filterStatus.rawValue
        }
        
        var newPagingData: PagingModel<Character> = try await apiService.requestHttp(method: .get, path: path, parameters: params, body: nil, headers: [:])
        newPagingData.pagingStatus = .loadedData
        return newPagingData
    }
}
