//
//  FilterCell.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import SwiftUI

struct FilterCell: View {
    let filter: FilterStatus
    let isSelected: Bool
    
    var body: some View {
        Text(filter.rawValue)
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .foregroundColor(isSelected ? .white : .titleBlue)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.blueGrayBorder : Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blueGrayBorder, lineWidth: 1)
                )
    }
}

#Preview {
    FilterCell(filter: .alive, isSelected: true)
}
