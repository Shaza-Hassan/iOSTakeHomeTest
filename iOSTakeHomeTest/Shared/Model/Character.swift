//
//  Character.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import Foundation

struct Character: Codable {
    let name: String
    let image: String
    let species: String
    let status: String
    let gender: String
    
    var characterStatus: FilterStatus {
        FilterStatus(rawValue: status) ?? .unknown
    }
}

let dummyCharacter: Character = dummyCharacters[0]

let dummyCharacters: [Character] = [
    Character(
        name: "Rick Sanchez",
        image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Male"
    ),
    Character(
        name: "Morty Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Male"
    ),
    Character(
        name: "Summer Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Female"
    ),
    Character(
        name: "Beth Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Female"
    ),
    Character(
        name: "Jerry Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Male"
    )
]
