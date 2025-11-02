//
//  FavoriteDishes.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//
import SwiftUI

struct FavoriteDishes: View{
    enum Mode {
        case editing
        case viewing
    }
    let mode: Mode
    @Binding var dishes: [String]
    @State private var newDish: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6){
            if mode == .viewing && !dishes.isEmpty{
                HStack{
                    Image(systemName: "fork.knife")
                    Text("Favorite Dishes")
                        .font(.headline)
                    Spacer()
                }
                .padding(.vertical, 10)
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 130))],
                    spacing:5,
                ){
                    ForEach(dishes, id: \.self) {dish in
                        Dish(name: dish)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 1)
            }
               
            }
            if mode == .editing{
                HStack(){
                    VStack{
                        InputRow(label: "Ulubione Dania",
                                 placeholder: "Kuciak w miodem, makaron sojowy....",
                                 value: $newDish)
                        .frame(maxWidth: 300)
                    }
                    VStack{
                        Spacer()
                        Button{
                            if !newDish.isEmpty{
                                dishes.append(newDish)
                                newDish = ""
                            }
                        }label: {
                            Text("Dodaj")
                                .foregroundColor(Color.black)
                                .font(.headline)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.top)
                    }
                    
                }
                if !dishes.isEmpty {
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 130))],
                        spacing: 5
                    ) {
                        ForEach(dishes, id: \.self) { dish in
                            Dish(name: dish)
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)  // ← Dodaj to!
                    .padding(.top, 10)
                }
                
            }
            
        
        }

    }
}
struct Dish: View {
    let name: String
    var body: some View {
        Text(name)
            .padding(4)
            .padding(.horizontal, 5)
            .foregroundColor(.brown)
            .font(.subheadline)
            .bold()
            .background(.yellow.opacity(0.1))
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.orange, lineWidth: 1)
            )
    }
}

#Preview {
    AddRestaurantView()
}
