//
//  PagingModel.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import Foundation

struct PagingModel<T: Codable> : Codable {
    let results: [T]
    
    let info: PagingInfo
    
    var hasNext: Bool {
        return info.next != nil
    }
    
    var canLoadMore: Bool {
        return hasNext && pagingStatus == .loaded
    }
    
    let pagingStatus: PagingStatus
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
    case loaded
    case loadingMore
    case firstPageError
    case loadingMoreError
}
