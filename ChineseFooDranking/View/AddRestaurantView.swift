//
//  AddingRestaurandView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//

import SwiftUI

struct AddRestaurantView: View {
    @EnvironmentObject var restaurantManager: RestaurantManager
    @Environment(\.dismiss) var dismiss
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var cuisine: String = ""
    @State var favoriteDishes: [String] = []
    @State private var notes: String = ""
    @State private var selectedImageData: Data?
    @State private var foodScore: Double = 5.0
    @State private var serviceScore: Double = 5.0
    @State private var ambianceScore: Double = 5.0
    @State private var valueScore: Double = 5.0

    
    let cuisineTypes = ["Chińska", "Wietnamska", "Fusion", "Indyjska", "Tajska"]

    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Text("Dodaj Nową Restaurację")
                        .font(.title)
                        .bold(true)
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
                
                InputRow(label: "Nazwa Restauracji *",
                         placeholder: "Kim Long",
                         value: $name)

                InputRow(label: "Adres",
                         placeholder: "Pruszkowska 7",
                         value: $address)

                SelectRow(label: "Typ Kuchni",
                          placeholder: "Wybierz typ kuchni",
                          options: cuisineTypes,
                          selection: $cuisine)
                PhotoPicker(selectedImageData: $selectedImageData)
                Ratings(
                                   isEditable: true,
                                   foodScore: $foodScore,
                                   serviceScore: $serviceScore,
                                   ambianceScore: $ambianceScore,
                                   valueScore: $valueScore
                               )
                FavoriteDishes(mode: .editing, dishes: $favoriteDishes)
                InputRow(label: "Notatki",
                         placeholder: "Dodaj komentarz lub uwagę do restauracji...",
                         value: $notes)
                .padding(.vertical)
                HStack{
                    Button{
                        dismiss()
                    }label: {
                        Text("Anuluj")
                            .foregroundColor(Color.black)
                            .font(.headline)
                    }
                    .padding()
                    .frame(width: 180)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    Button{
                        let newRestaurant = Restaurant(
                            name: name,
                            address: address,
                            cuisine: cuisine,
                            imageData: selectedImageData,
                            foodScore: foodScore,
                            serviceScore: serviceScore,
                            ambianceScore: ambianceScore,
                            valueScore: valueScore,
                            favoriteDishes: favoriteDishes,
                            notes: notes
                        )
                        restaurantManager.addRestaurant(newRestaurant)
                        dismiss()
                    }label: {
                        Text("Dodaj Restaurację")
                            .foregroundColor(Color.white)
                            .font(.headline)
    
                    }
                    .padding()
                    .frame(width: 180)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                    )
                    
                }
            }
            .padding(.top, 8)
        }
    }
}




#Preview {
    AddRestaurantView()
}
