//
//  CharatersViewModel.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 14/08/2024.
//

import Foundation

class CharatersViewModel {
    
    var charatersRepository: CharatersRepository
    var characters: [Character] {
        return charactesPagingModel.results
    }
    var filterStatus: FilterStatus?
    
    @Published 
    var charactesPagingModel: PagingModel<Character> = PagingModel.empty
    
    var error:String? = nil
    
    init(charatersRepository: CharatersRepository) {
        self.charatersRepository = charatersRepository
    }
    
    @MainActor
    func setFilterStatus(filterStatus: FilterStatus?) {
        self.filterStatus = filterStatus
        charactesPagingModel = PagingModel.empty
        fetchCharacters()
    }
    
    @MainActor
    func fetchCharacters()  {
        Task{
            do {
                let pagingModel = try await charatersRepository.fetchCharacters(pagingModel: charactesPagingModel,filterStatus: filterStatus)
                charactesPagingModel = pagingModel
            } catch {
                switch charactesPagingModel.pagingStatus {
                case .idle,.firstPageLoading:
                    charactesPagingModel.pagingStatus = .firstPageError
    
                case .loadingMore:
                    charactesPagingModel.pagingStatus = .loadingMoreError
                    
                default:
                    break
                }
                self.error = error.localizedDescription
                charactesPagingModel = charactesPagingModel
            }
        }
    }
    
}
