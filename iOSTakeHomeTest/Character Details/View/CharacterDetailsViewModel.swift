//
//  CharacterDetailsViewModel.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 15/08/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    
    @Published var character: Character?
    
    init(character: Character) {
        self.character = character
    }
}
