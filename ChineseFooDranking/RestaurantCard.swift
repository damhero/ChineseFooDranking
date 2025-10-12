//
//  RestaurantCard.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

struct RestaurantCard: View {
    var body: some View {
        VStack(spacing: 0){
            headerImage
            ratingSection
            
        }
        .background(.white)
        .cornerRadius(10)
    }
    var headerImage: some View {
        ZStack {
            Image("Cover1")
                .resizable()
                .scaledToFill()
            Text("An an Asean Bistro")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title3)
                .offset(x: -45, y: 50)
            Image(systemName: "mappin")
                .foregroundColor(.white)
                .offset(x: -130, y: 75)
                .font(.subheadline)
            Text("Geodetów 5, Mysiadło")
                .foregroundColor(.white)
                .font(.subheadline)
                .offset(x: -45, y: 75)
                
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
            .padding(.horizontal, 5)
            ratingRow
            ratingRow
                .padding(.bottom, 10)
            Text("Kurczak z miode to jest taki benger ze nawet sobi tego nie wyobrazasz bratku.")
                .font(.subheadline)
                
        }
        .padding(5)
    }
    
    var ratingRow: some View {
        HStack{
            HStack{
                Text("Food")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("9")
                    .font(.subheadline)
                    .bold()

            }
            .padding(.horizontal, 10)
            .padding(5)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            HStack{
                Text("Food")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("9")
                    .font(.subheadline)
                    .bold()

            }
            .padding(.horizontal, 10)
            .padding(5)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    ContentView()
}
