//
//  AddingRestaurandView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//

import SwiftUI

struct AddRestaurantView: View {
    @Environment(\.dismiss) var dismiss
    @State private var restaurantName: String = ""
    @State private var address: String = ""
    @State private var cuisine: String = ""
    @State var dishes: [String] = ["Kuciak w miodem", "krewetki"]
    @State private var notes: String = ""

    
    let cuisineTypes = ["Chinese", "Vietnam", "Italian", "American", "Japanese"]

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
                         value: $restaurantName)

                InputRow(label: "Adres",
                         placeholder: "Pruszkowska 7",
                         value: $address)

                SelectRow(label: "Typ Kuchni",
                          placeholder: "Wybierz typ kuchni",
                          options: cuisineTypes,
                          selection: $cuisine)
                PhotoPicker()
                Ratings(isEditable: true)
                FavoriteDishes(mode: .editing, dishes: $dishes)
                InputRow(label: "Notatki",
                         placeholder: "Dodaj komentarz lub uwagę do restauracji...",
                         value: $notes)
            }
            .padding(.top, 8)
        }
    }
}




#Preview {
    AddRestaurantView()
}
