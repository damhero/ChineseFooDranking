//
//  RestaurantCard.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

struct RestaurantCard: View {
    @State private var showDetails = false
    let restaurant: Restaurant
    var onSave: (Restaurant) -> Void
    
    var body: some View {
        VStack(spacing: 0){
            headerImage
            ratingSection
            
        }
        .background(.white)
        .cornerRadius(10)
        
        .onTapGesture {
            showDetails = true;
        }
        .fullScreenCover(isPresented: $showDetails){
            RestaurantDetailView(restaurant: restaurant, onSave: onSave)
        }
    }
    var headerImage: some View {
        Group {
            if let imageData = restaurant.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray
            }
        }
        .frame(height: 200)
        .clipped()
        
        .overlay(alignment: .bottomLeading) {
            
            ZStack(alignment: .bottomLeading) {
                
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(restaurant.name)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title3)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin")
                            .font(.subheadline)
                        
                        Text(restaurant.address)
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
        .padding(.bottom, 10)
    }
    var ratingSection: some View {
        VStack(spacing: 10){
            HStack(spacing: 4){
                Image(systemName: "star.fill")
                    .font(.title3)
                    .foregroundColor(.yellow)
                Text("\(restaurant.rating, specifier: "%.1f")")
                    .font(.title2)
                    .bold()
                Text("/10")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                Text(restaurant.cuisine)
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
            ratingRow(label1: "Food", score1: restaurant.foodScore,
                          label2: "Service", score2: restaurant.serviceScore)
                
                ratingRow(label1: "Ambiance", score1: restaurant.ambianceScore,
                          label2: "Value", score2: restaurant.valueScore)
                .padding(.bottom, 10)
            Text("\"\(restaurant.notes)\"")
                .font(.subheadline.italic())
                .foregroundColor(.gray)
        }
        .padding(5)
    }
    
    func ratingRow(label1: String, score1: Double, label2: String, score2: Double) -> some View {
        HStack {
            HStack {
                Text(label1)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(Int(score1))")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.horizontal, 10)
            .padding(5)
            .background(.gray.opacity(0.2))
            .cornerRadius(10)
            
            HStack {
                Text(label2)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text("\(Int(score2))")
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

extension Restaurant {
    static var preview: Restaurant {
        Restaurant(
            name: "Golden Dragon",
            address: "128 Main Street",
            cuisine: "Cantonese",
            imageData: UIImage(named: "Cover1")?.jpegData(compressionQuality: 0.8),
            foodScore: 8.3,
            serviceScore: 9,
            ambianceScore: 8,
            valueScore: 7,
            favoriteDishes: ["kurczak", "krewetki"],
            notes: "Kurczak z miode to jest taki benger ze nawet sobi tego nie wyobrazasz bratku."
        )
    }
}

// Użycie:
#Preview {
    RestaurantCard(restaurant: .preview) { updatedRestaurant in
        // To jest tylko dla podglądu, więc nic nie robimy
        print("Preview saved: \(updatedRestaurant.name)")
    }
    .environmentObject(RestaurantManager())
}
