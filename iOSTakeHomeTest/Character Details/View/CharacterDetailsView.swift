//
//  CharacterDetailsView.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 15/08/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetailsView: View {
    
    @ObservedObject var viewModel: CharacterDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView{
            ZStack(alignment:.topLeading) {
                baseView
                
                backButton
            }
        }
        .frame(
            idealWidth: .infinity,
            maxWidth: .infinity,
            idealHeight: .infinity,
            maxHeight: .infinity,
            alignment: .leading
        )
        .ignoresSafeArea(.all)
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
    }
    
    var backButton: some View {
        Image(systemName: "arrow.backward")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 16, height: 16)
            .padding(16)
            .background()
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
            .padding(.top,60)
            .padding(.leading,16)
    }
    
    var baseView: some View {
        VStack(alignment:.leading,spacing: 0){
            
            KFImage(URL(string: viewModel.character?.image ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(idealWidth: .infinity, maxWidth: .infinity)
                .cornerRadius(50)
            
            basicInfo
            
            Group {
                Text("Location : ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.titleBlue) +
                Text(viewModel.character?.location.name ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                .foregroundColor(.spicesColor)
            }
            .padding(.top,30)
            .padding(.horizontal,20)
        }
        .frame(idealWidth: .infinity, maxWidth: .infinity,alignment: .leading)
    }
    
    var basicInfo: some View {
        HStack(alignment: .top,spacing:0){
            VStack(alignment:.leading,spacing:12){
                Text(viewModel.character?.name ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.titleBlue)
                
                Text(viewModel.character?.species ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.spicesColor) +
                Text(" • ") .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.spicesColor) +
                Text(viewModel.character?.gender ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.genderColor)
            }
            
            Spacer()
            
            Text(viewModel.character?.status ?? "")
                .foregroundColor(.titleBlue)
                .padding(.horizontal,16)
                .padding(.vertical,8)
                .background(Color.statusColor)
                .cornerRadius(20)
            
            
        }
        .frame(idealWidth: .infinity, maxWidth: .infinity,alignment: .leading)
        .padding(.top,24)
        .padding(.horizontal,20)
    }
}

#Preview {
    CharacterDetailsView(viewModel: CharacterDetailsViewModel(character: dummyCharacter))
}
