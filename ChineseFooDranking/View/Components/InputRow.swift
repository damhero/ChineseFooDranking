//
//  InputRow.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//

import SwiftUI

struct InputRow: View {
    let label: String
    let placeholder: String
    @Binding var value: String
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack{
                Text(label)
                    .lineLimit(1) // jedna linia, bez zawijania
                    .truncationMode(.tail)
            }

            TextField(placeholder, text: $value)
                .focused($isFocused)
                .padding()
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isFocused ? Color.black : Color.gray, lineWidth: 1)
                )
        }
        .padding(.horizontal)
    }
}
