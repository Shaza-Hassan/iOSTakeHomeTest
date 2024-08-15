//
//  CharatersViewModelTests.swift
//  iOSTakeHomeTestTests
//
//  Created by Shaza Hassan on 15/08/2024.
//

import Foundation
import XCTest
import MockingKit
import Combine
@testable import iOSTakeHomeTest

final class CharatersViewModelTests: XCTestCase {
    
    var charatersRepositoryMock: CharatersRepositoryMock!
    var viewModel: CharatersViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        charatersRepositoryMock = CharatersRepositoryMock()
        viewModel = CharatersViewModel(charatersRepository: charatersRepositoryMock)
    }
    
    override func tearDown() {
        charatersRepositoryMock = nil
        viewModel = nil
        cancellables = []

        super.tearDown()
    }
    
    @MainActor 
    func testSetFilterStatus() {
        // Define the filter status
        let filterStatus = FilterStatus.alive
        charatersRepositoryMock.registerResult(for:\.fetchCharacters){ _ in
            return PagingModel()
        }
        // Call setFilterStatus
        viewModel.setFilterStatus(filterStatus: filterStatus)
        
        // Verify filterStatus is set correctly
        XCTAssertEqual(viewModel.filterStatus, filterStatus)
    }
    
    @MainActor
    func testFetchCharactersWithFilter() async {
        // Define the filter status
        let filterStatus = FilterStatus.alive
        let expectedData = PagingModel(
            results: [dummyCharacter],
            info: PagingInfo(count: 1, pages: 1, next: nil, prev: nil),
            pagingStatus: .loadedData
        )
        charatersRepositoryMock.registerResult(for:\.fetchCharacters){ _ in
            return expectedData
        }
        
        viewModel.setFilterStatus(filterStatus: filterStatus)

        // Wait for the viewModel to update
        let expectation = XCTestExpectation(description: "Wait for fetchCharacters to update the viewModel")
        viewModel.$charactesPagingModel
            .dropFirst() // Drop initial value
            .receive(on: DispatchQueue.main)
            .sink { updatedPagingModel in
                if updatedPagingModel.pagingStatus == .loadedData {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        await fulfillment(of: [expectation], timeout: 1.0)

        // Verify filterStatus is set correctly
        XCTAssertEqual(viewModel.charactesPagingModel.pagingStatus,expectedData.pagingStatus)
    }
    
}
