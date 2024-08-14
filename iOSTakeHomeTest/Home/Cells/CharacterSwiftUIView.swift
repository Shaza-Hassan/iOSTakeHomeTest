//
//  CharacterSwiftUIView.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import SwiftUI
import Kingfisher

struct CharacterSwiftUIView: View {
    let character: Character
    
    var body: some View {
        HStack(alignment:.top,spacing: 16){
            KFImage(URL(string: character.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 8){
                Text(character.name)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.titleBlue)
                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.subtitleBlue)
            }
            
        }
        .padding(16)
        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(borderColor, lineWidth: 1)
                )
        )
    }
    
    var borderColor: Color {
        switch character.characterStatus {
        case .alive:
            return .aliveColor
        case .dead:
            return .deadColor
        case .unknown:
            return .lightGrayBorder
        }
    }
    
    var backgroundColor: Color {
        switch character.characterStatus {
        case .alive:
            return .aliveColor
        case .dead:
            return .deadColor
        case .unknown:
            return .white
        }
    }
}

#Preview {
    CharacterSwiftUIView(character: dummyCharacter)
}
