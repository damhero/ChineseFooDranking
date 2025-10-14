//
//  RestaurantView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 12/10/2025.
//

import SwiftUI

struct RestaurantDetailView: View {
    @State var dishes: [String] = ["Kuciak w miodem", "krewetki"]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("An an Asean Bistro")
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title2)
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(10)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)

                headerImage
                VStack(spacing: 0){
                    
                    ratingSection
                    FavoriteDishes(mode: .viewing, dishes: $dishes)
                    personalNotes

                    
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
            }
        }
        
    }
    var headerImage: some View {
        ZStack {
            Image("Cover1")
                .resizable()
                .scaledToFill()
                
        }
        .frame(height: 200)
        .clipShape(Rectangle())
        .padding(.bottom, 10)
    }
    var ratingSection: some View {
        VStack(spacing: 10){
            HStack(spacing: 4){
                Image(systemName: "star.fill")
                    .font(.title3)
                    .foregroundColor(.yellow)
                Text("8.3")
                    .font(.title2)
                    .bold()
                Text("/10")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                Text("Cantonese")
                    .bold()
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(.red.opacity(0.1))
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.red, lineWidth: 1)
                    )
                    
            }
            HStack {
                Image(systemName: "mappin")
                    .foregroundColor(.black)
                    .font(.subheadline)
                Text("Geodetów 5, Mysiadło")
                    .foregroundColor(.black)
                    .font(.subheadline)
                Spacer()
            }
                .padding(.bottom, 10)
            Ratings(isEditable: false)
                
        }
    }

    //PERSONAL NOTES
    var personalNotes: some View {
        VStack{
            HStack{
                Text("Notatki")
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.bottom, 3)
                Spacer()
            }

            Text("Kurczak z miode to jest taki benger ze nawet sobi tego nie wyobrazasz bratku. Pani tylko ma czasem problem ze zrozumieniem wiec upewnij sie ze wie o co ja prosisz.")
                .font(.subheadline)
        }
    }

}




#Preview {
    RestaurantDetailView()
}
