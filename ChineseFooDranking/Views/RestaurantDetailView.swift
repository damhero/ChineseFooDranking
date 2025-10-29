//
//  RestaurantView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 12/10/2025.
//

import SwiftUI

struct RestaurantDetailView: View {
    let restaurant: Restaurant
    var onSave: (Restaurant) -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false
    @State private var foodScore: Double
    @State private var serviceScore: Double
    @State private var ambianceScore: Double
    @State private var valueScore: Double
    
    init(restaurant: Restaurant, onSave: @escaping (Restaurant) -> Void) {
        self.restaurant = restaurant
        self.onSave = onSave
        _foodScore = State(initialValue: restaurant.foodScore)
        _serviceScore = State(initialValue: restaurant.serviceScore)
        _ambianceScore = State(initialValue: restaurant.ambianceScore)
        _valueScore = State(initialValue: restaurant.valueScore)
        }
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text(restaurant.name)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.title2)
                    Spacer()
                    Button {
                        withAnimation {
                            isEditing.toggle()
                            
                            if !isEditing {
                                var updatedRestaurant = restaurant
                                updatedRestaurant.foodScore = foodScore
                                updatedRestaurant.serviceScore = serviceScore
                                updatedRestaurant.ambianceScore = ambianceScore
                                updatedRestaurant.valueScore = valueScore
                                
                                onSave(updatedRestaurant)
                            }
                        }
                    } label: {
                        Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(10)
                    }
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
                    FavoriteDishes(mode: .viewing, dishes: .constant(restaurant.favoriteDishes))
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
            Ratings(
                    isEditable: isEditing,
                    foodScore: $foodScore,
                    serviceScore: $serviceScore,
                    ambianceScore: $ambianceScore,
                    valueScore: $valueScore
                    )
                
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

            Text(restaurant.notes)
                .font(.subheadline)
        }
    }

}




#Preview {
    // 1. Używamy restauracji .preview, którą zdefiniowałeś wcześniej
    //    (Zakładam, że jest ona dostępna jako 'Restaurant.preview')
    
    RestaurantDetailView(restaurant: .preview) { updatedRestaurant in
        
        // 2. To jest brakujący blok 'onSave'.
        //    W podglądzie nie musimy nic robić, możemy po prostu
        //    wydrukować wiadomość do konsoli, aby sprawdzić, czy działa.
        print("Preview: Przycisk zapisu naciśnięty dla \(updatedRestaurant.name)")
    }
}
