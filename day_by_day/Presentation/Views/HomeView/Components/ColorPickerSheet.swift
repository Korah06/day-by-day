//
//  ColorPickerSheet.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI

struct ColorPickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedColor: Color

    let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple,
        .pink, .cyan, .indigo, .mint, .teal, .brown,
    ]
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    var body: some View {
        VStack(alignment: .leading) {
            Text("selectColor")
                .font(.title)
                .bold()
            Divider()
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(
                                    selectedColor == color
                                    ? .primary : Color.clear,
                                    lineWidth: 3
                                )
                        )
                        .onTapGesture {
                            selectedColor = color
                            dismiss()
                        }
                }
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var selectedColor: Color = .blue
    ColorPickerSheet(selectedColor: $selectedColor)
}
