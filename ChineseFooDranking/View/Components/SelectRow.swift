//
//  SelectRow.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//

import SwiftUI

struct SelectRow: View {
    let label: String
    let placeholder: String
    let options: [String]
    @Binding var selection: String
    @State private var isExpanded = false

    private let fieldHeight: CGFloat = 52
    private let maxListHeight: CGFloat = 220

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Etykieta w jednej linii
            HStack {
                Text(label)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
            }
            .padding(.horizontal)

            // Pole jako przycisk
            let field = HStack {
                Text(selection.isEmpty ? placeholder : selection)
                    .foregroundColor(selection.isEmpty ? .gray : .primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .frame(height: fieldHeight)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(selection.isEmpty ? Color.gray : Color.black, lineWidth: 1)
            )
            .contentShape(Rectangle())

            // Kontener pola z overlayem dropdownu (nie zmienia layoutu)
            ZStack(alignment: .topLeading) {
                Button {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        isExpanded.toggle()
                    }
                } label: {
                    field
                }
                .buttonStyle(.plain)
                .zIndex(100) // pole nad innymi

                // Dropdown jako overlay — renderowany "poniżej" pola
                if isExpanded {
                    VStack(spacing: 0) {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(options, id: \.self) { option in
                                    Button {
                                        selection = option
                                        withAnimation(.easeInOut(duration: 0.15)) {
                                            isExpanded = false
                                        }
                                    } label: {
                                        HStack {
                                            Text(option)
                                                .foregroundColor(.primary)
                                            Spacer()
                                            if option == selection {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.accentColor)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .frame(height: 44)
                                        .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)

                                    if option != options.last {
                                        Divider().padding(.leading)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: maxListHeight)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                    .padding(.top, fieldHeight + 8) // pozycja pod polem
                    .transition(.opacity)
                    .zIndex(200) // dropdown nad polem
                    .allowsHitTesting(true)
                }
            }
            .padding(.horizontal)
            // brak .clipped(), żeby overlay mógł wyjść poza SelectRow
        }
        .zIndex(isExpanded ? 300 : 1) // cały SelectRow nad sąsiadami w ScrollView
    }
}
