//
//  Ratings.swift
//  ChineseFooDranking
//
//  Created by Damian Brudkowski on 13/10/2025.
//
import SwiftUI


struct Ratings: View {
    let isEditable: Bool
    @Binding var foodScore: Double
    @Binding var serviceScore: Double
    @Binding var ambianceScore: Double
    @Binding var valueScore: Double
    
    //RATING BREAKDOWN
    var body: some View {
        VStack{
            HStack{
                Text("OCENY")
                Spacer()
            }
            .font(.callout)
            .padding(.top, 10)
            .padding(.bottom, 0)
            .padding(.horizontal, 20)
            RatingRow(emoji: "🍜", label: "Jedzenie", score: $foodScore, color: .red, isEditable: isEditable)
            RatingRow(emoji: "👨‍🍳", label: "Obsługa", score: $serviceScore, color: .blue, isEditable: isEditable)
            RatingRow(emoji: "🏮", label: "Klimat", score: $ambianceScore, color: .purple, isEditable: isEditable)
            RatingRow(emoji: "💰", label: "Value", score: $valueScore, color: .green, isEditable: isEditable)
        }
        .padding(.bottom, 10)
        .background(.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

//RATING ROW
struct RatingRow: View{
    let emoji: String
    let label: String
    @Binding var score: Double
    let color: Color
    let isEditable: Bool
    
    var body: some View {
        HStack{
            HStack{
                HStack{
                    Text(emoji)
                    Text(label)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                .frame(width: 100, alignment: .leading)
                if isEditable {
                    Slider(value: $score, in: 0...10, step: 1)
                        .tint(color)
                    Text("\(Int(score))")
                        .font(.subheadline)
                        .bold()
                }else{
                    ProgressView(value: score / 10.0)
                        .tint(color)
                        .scaleEffect(x:0.8,y:2)
                    Text("\(Int(score))")
                        .font(.subheadline)
                        .bold()
                }
                
            }
            .padding(5)
            .padding(.horizontal, 10)
        }
        .padding(.horizontal, 5)
    }
}


#Preview {
    @Previewable @State var food = 5.0
    @Previewable @State var service = 5.0
    @Previewable @State var ambiance = 5.0
    @Previewable @State var value = 10.0
    
    Ratings(
        isEditable: true,
        foodScore: $food,
        serviceScore: $service,
        ambianceScore: $ambiance,
        valueScore: $value
    )
}
