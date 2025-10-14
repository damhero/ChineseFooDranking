//
//  PhotoPicker.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//
import SwiftUI
import PhotosUI

struct PhotoPicker : View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    var body: some View {
        VStack {
            if let data = selectedImageData,
               let image = UIImage(data: data) {
                ZStack(alignment: .topTrailing){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    Button {
                        selectedImageData = nil
                    }label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title2)
    
                    }
                    .padding(8)
                }
            } else {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    VStack(spacing: 8) {
                        Image(systemName: "photo.badge.plus")
                            .font(.system(size: 28))
                            .foregroundColor(.gray)
                        Text("Dodaj zdjęcie")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, minHeight: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                            .foregroundColor(.gray.opacity(0.5))
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
    }
}
#Preview {
    AddRestaurantView()
}
