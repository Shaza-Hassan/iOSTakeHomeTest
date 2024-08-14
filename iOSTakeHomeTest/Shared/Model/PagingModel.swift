//
//  PagingModel.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import Foundation

struct PagingModel<T: Codable> : Codable {
    var results: [T] = []
    
    var info: PagingInfo?
    
    var hasNext: Bool {
        return info?.next != nil
    }
    
    var canLoadMore: Bool {
        return hasNext && pagingStatus == .loadedData
    }
    
    var pagingStatus: PagingStatus? = .idle
        
    static var empty: PagingModel {
        return PagingModel(results: [], info: PagingInfo(count: 0, pages: 0, next: nil, prev: nil), pagingStatus: .idle)
    }
}


struct PagingInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

enum PagingStatus: Codable {
    case idle
    case firstPageLoading
    case loadedData
    case loadingMore
    case firstPageError
    case loadingMoreError
}
