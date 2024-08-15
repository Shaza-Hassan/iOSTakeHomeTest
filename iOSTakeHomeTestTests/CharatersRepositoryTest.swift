//
//  CharatersRepositoryTest.swift
//  iOSTakeHomeTestTests
//
//  Created by Shaza Hassan on 15/08/2024.
//

import XCTest
import MockingKit
@testable import iOSTakeHomeTest

final class CharactersRepositoryTests: XCTestCase {
    
    var apiServiceMock: APIClientProtocolMock!
    var repository: CharatersRepository!
    
    override func setUp() {
        super.setUp()
        apiServiceMock = APIClientProtocolMock()
        repository = CharatersRepository(apiService: apiServiceMock)
    }
    
    override func tearDown() {
        apiServiceMock = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchCharactersWithPaging() async throws {
        let nextURL = "https://example.com/api/nextPage"
        let character = dummyCharacter
        let pagingModel = PagingModel<Character>(
            results: [character], 
            info: PagingInfo(count:0,pages: 0, next: nextURL, prev: nil),
            pagingStatus: .loadedData
        )
        
        let expectedPagingModel = PagingModel<Character>(
            results: [character, character], 
            info: PagingInfo(count: 0, pages: 0, next: nil, prev: nil),
            pagingStatus: .loadedData
        )
        
        // Set up the mock to return the expected value
        apiServiceMock.requestHttpCustomBaseUrlMethodPathParametersBodyHeadersReturnValue = expectedPagingModel
        
        let result = try await repository.fetchCharacters(pagingModel: pagingModel, filterStatus: nil)
        
        XCTAssertEqual(result.results.count, 3)
        XCTAssertEqual(result.pagingStatus, .loadedData)
        XCTAssertEqual(result.results.first?.name, character.name)

    }
    
    func testFetchCharactersWithoutPaging() async throws {
        let character = dummyCharacter
        let expectedPagingModel = PagingModel<Character>(
            results: [character],
            info: PagingInfo(count: 1, pages: 1, next: nil, prev: nil),
            pagingStatus: .loadedData
        )
        
        // Set up the mock to return the expected value
        apiServiceMock.requestHttpMethodPathParametersBodyHeadersReturnValue = expectedPagingModel
        
        let pagingModel = PagingModel<Character>(
            results: [],
            info: nil,
            pagingStatus: .idle
        )
        
        let result = try await repository.fetchCharacters(pagingModel: pagingModel, filterStatus: nil)
        
        XCTAssertEqual(result.results.count, 1)
        XCTAssertEqual(result.pagingStatus, .loadedData)
        XCTAssertEqual(result.results.first?.name, character.name)
    }
}
