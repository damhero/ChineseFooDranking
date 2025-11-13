//
//  RestaurantView.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 12/10/2025.
//

import SwiftUI
import PhotosUI

struct RestaurantDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    let restaurant: Restaurant
    @Binding var selectedRestaurant: Restaurant?
    var onSave: (Restaurant) -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false
    @State private var foodScore: Double
    @State private var serviceScore: Double
    @State private var ambianceScore: Double
    @State private var valueScore: Double
    @State private var editableDishes: [String]
    @State private var editableNotes: String
    @State private var editableName: String
    @State private var editableAddress: String
    @State private var editableImageData: Data?
    @State private var showPhotoPicker = false
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var showingDeleteAlert = false
    
    init(restaurant: Restaurant, selectedRestaurant: Binding<Restaurant?>, onSave: @escaping (Restaurant) -> Void) {
        self.restaurant = restaurant
        self._selectedRestaurant = selectedRestaurant
        self.onSave = onSave
        _foodScore = State(initialValue: restaurant.foodScore)
        _serviceScore = State(initialValue: restaurant.serviceScore)
        _ambianceScore = State(initialValue: restaurant.ambianceScore)
        _valueScore = State(initialValue: restaurant.valueScore)
        _editableDishes = State(initialValue: restaurant.favoriteDishes)
        _editableNotes = State(initialValue: restaurant.notes)
        _editableName = State(initialValue: restaurant.name)
        _editableAddress = State(initialValue: restaurant.address)
        _editableImageData = State(initialValue: nil)
        
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    if isEditing {
                        TextField("Nazwa restauracji", text: $editableName)
                    }else{
                        Text(editableName)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title2)
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            isEditing.toggle()
                            
                            if !isEditing {
                                
                                // 1. Stwórz zaktualizowany obiekt restauracji (z danymi tekstowymi)
                                var updatedRestaurant = restaurant
                                updatedRestaurant.foodScore = foodScore
                                updatedRestaurant.serviceScore = serviceScore
                                updatedRestaurant.ambianceScore = ambianceScore
                                updatedRestaurant.valueScore = valueScore
                                updatedRestaurant.favoriteDishes = editableDishes
                                updatedRestaurant.notes = editableNotes
                                updatedRestaurant.name = editableName
                                updatedRestaurant.address = editableAddress
                                
                                // 2. Wywołaj 'onSave', aby wysłać dane tekstowe (PUT JSON)
                                //    To wywoła 'viewModel.updateRestaurant(...)'
                                onSave(updatedRestaurant)
                                
                                // 3. Sprawdź, czy użytkownik wybrał NOWY obrazek
                                if let newImageData = editableImageData, let id = restaurant.id {
                                    // Jeśli tak, wywołaj *oddzielną* funkcję do wysłania obrazka (POST Multipart)
                                    Task {
                                        await viewModel.uploadImage(id: id, imageData: newImageData)
                                    }
                                }
                                
                                // 4. Zamknij widok (teraz przez binding)
                                selectedRestaurant = nil
                            }
                        }
                    } label: {
                        Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(10)
                    }
                    Button {
                        selectedRestaurant = nil
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(10)
                    }
                    

                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .zIndex(1)

                headerImage
                VStack(spacing: 0){
                    
                    ratingSection
                    FavoriteDishes(mode: isEditing ? .editing : .viewing,
                                   dishes: $editableDishes)
                    personalNotes
                    
                    if isEditing {
                        Button(role: .destructive) {
                            showingDeleteAlert = true
                        } label: {
                            Label("Usuń Restaurację", systemImage: "trash.fill")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 30) // Duży odstęp od reszty
                    }

                    
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                
                .alert("Na pewno usunąć?", isPresented: $showingDeleteAlert) {
                    Button("Usuń", role: .destructive) {
                        // To jest ostateczna akcja usuwania
                        Task {
                            // Wywołujemy funkcję usuwania z ViewModelu
                            await viewModel.deleteRestaurant(restaurant)
                            // Zamykamy widok
                            selectedRestaurant = nil
                        }
                    }
                    Button("Anuluj", role: .cancel) { }
                } message: {
                    Text("Tej akcji nie można cofnąć. Restauracja \"\(restaurant.name)\" zostanie usunięta.")
                }
            }
        }
        
    }
    var headerImage: some View {
        ZStack(alignment: .topTrailing) {
            
            // 1. Sprawdź, czy mamy NOWY obrazek w pamięci
            if let newImageData = editableImageData, let uiImage = UIImage(data: newImageData) {
                
                // Jeśli tak, pokaż ten nowy obrazek
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            
            } else {
                
                // 2. Jeśli nie, pobierz obrazek z serwera przez AsyncImage
                AsyncImage(url: restaurant.imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Image(systemName: "photo.artframe").font(.largeTitle).foregroundColor(.gray.opacity(0.6))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.1))
                    default:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.1))
                    }
                }
            }
            
            // Przycisk edycji (bez zmian)
            if isEditing {
                Button {
                    showPhotoPicker = true
                } label: {
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(10)
                .padding(.top, 30)
            }
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .clipShape(Rectangle())
        .photosPicker(
            isPresented: $showPhotoPicker,
            selection: $selectedPhoto
        )
        .onChange(of: selectedPhoto) { _, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    editableImageData = data
                }
            }
        }
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
            HStack {
                Image(systemName: "mappin")
                    .foregroundColor(.black)
                    .font(.subheadline)
                if isEditing {
                    TextField("Adres", text: $editableAddress)
                }else{
                    Text(editableAddress)
                        .foregroundColor(.black)
                        .font(.subheadline)
                }

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
            
            if isEditing {
                TextEditor(text: $editableNotes)
                    .frame(minHeight: 100)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }else{
                Text(editableNotes)
                    .font(.subheadline)
            }

        }
    }

}




#Preview {
    RestaurantDetailView(
        restaurant: .preview,
        selectedRestaurant: .constant(Restaurant.preview),
        onSave: { _ in }
    )
    .environmentObject(ViewModel())
}
