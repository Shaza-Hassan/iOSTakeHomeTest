//
//  CharatersRepositoryMock.swift
//  iOSTakeHomeTestTests
//
//  Created by Shaza Hassan on 15/08/2024.
//

import Foundation
import MockingKit
@testable import iOSTakeHomeTest

class CharatersRepositoryMock : Mock, CharactersGatway {
    
    lazy var fetchCharacters = AsyncMockReference(fetchCharacters)
    
    func fetchCharacters(pagingModel: PagingModel<Character>, filterStatus: FilterStatus?) async throws -> PagingModel<Character> {
        return await call(fetchCharacters, args: (pagingModel, filterStatus))
    }
    
}
