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
    let location: Location
    
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
        gender: "Male",
        location: Location(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3")
    ),
    Character(
        name: "Morty Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Male",
        location: Location(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1")
    ),
    Character(
        name: "Summer Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Female",
        location: Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20")
    ),
    Character(
        name: "Beth Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Female",
        location: Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20")
    ),
    Character(
        name: "Jerry Smith",
        image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
        species: "Human",
        status: "Alive",
        gender: "Male",
        location: Location(name: "Earth (Replacement Dimension)", url: "https://rickandmortyapi.com/api/location/20")
    )
]

