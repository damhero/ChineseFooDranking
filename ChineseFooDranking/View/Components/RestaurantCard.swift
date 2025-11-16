//
//  RestaurantCard.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 11/10/2025.
//

import SwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant
    let viewModel: ViewModel
    var onSave: (Restaurant) -> Void
    var medal : MedalType? = nil
    
    var body: some View {
        VStack(spacing: 0){
            headerImage
            ratingSection
            
        }
        .background(.white)
        .cornerRadius(10)
        
    }
    
    var headerImage: some View {
        // AsyncImage automatycznie pobierze obrazek z URL-a
        AsyncImage(url: restaurant.imageURL) { phase in
            switch phase {
            case .empty:
                // Placeholder, gdy obrazek się ładuje
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
            case .success(let image):
                // Obrazek załadowany pomyślnie
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                // Błąd lub brak obrazka (placeholder ze zdjęcia)
                ZStack {
                    Color.gray.opacity(0.1)
                    Image(systemName: "photo.artframe")
                        .font(.largeTitle)
                        .foregroundColor(.gray.opacity(0.6))
                }
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: 200) // Ustawiamy wysokość dla AsyncImage
        .clipped()
        .overlay(alignment: .bottomLeading) {
            // Ta część (gradient i tekst) pozostaje bez zmian
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
        .overlay(alignment: .topLeading) {
                // Ta logika sprawdza, czy medal został przekazany
                if let medal = medal {
                    Image(systemName: "medal.fill")
                        .font(.largeTitle) // Dopasuj rozmiar
                        .foregroundColor(medal.color)
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 2)
                        .padding(8) // Mały odstęp od rogu
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
                Text("\(restaurant.rating ?? 0.0, specifier: "%.1f")")
                    .font(.title2)
                    .bold()
                Text("/10")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                if restaurant.cuisine != ""{
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
                    
            }
            .padding(.horizontal, 5)
            ratingRow(label1: "Jedzenie", score1: restaurant.foodScore,
                          label2: "Obsługa", score2: restaurant.serviceScore)
                
                ratingRow(label1: "Klimat", score1: restaurant.ambianceScore,
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
            cuisine: "Fusion",
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
    RestaurantCard(restaurant: .preview, viewModel: ViewModel()) { updatedRestaurant in
        print("Preview saved: \(updatedRestaurant.name)")
    }
}

