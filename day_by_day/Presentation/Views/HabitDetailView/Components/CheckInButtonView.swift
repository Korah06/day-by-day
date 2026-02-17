//
//  CheckInButton.swift
//  day_by_day
//
//  Created by Mario Espasa Planells on 14/2/26.
//

import SwiftUI

struct CheckInButton: View {
    let action: () -> Void
    @State private var isButtonVisible = false
    @State private var showShadow = false
    
    var body: some View {
        Button(action: {
            action()
            
            // Animate shadow
            withAnimation(.easeOut(duration: 0.5)) {
                showShadow = true
            }
            
            // Fade out the shadow after a brief moment
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 0.3)) {
                    showShadow = false
                }
            }
        }) {
            Label("checkIn", systemImage: "checkmark")
                .font(.title3)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
        }
        .buttonStyle(.glassProminent)
        .shadow(
            color: Color.blue.opacity(showShadow ? 1 : 0),
            radius: showShadow ? 40 : 0,
            x: 0,
            y: 0
        )
        .padding()
        .scaleEffect(isButtonVisible ? 1 : 0.5)
        .opacity(isButtonVisible ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isButtonVisible = true
            }
        }
    }
}

#Preview {
    CheckInButton {
        print("Check in tapped")
    }
}
