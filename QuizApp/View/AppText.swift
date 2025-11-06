//
//  ReusableText.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 15/06/25.
//

import SwiftUI

enum AppFontSize: CGFloat {
    case small = 16
    case medium = 20
    case large = 30
    case extraLarge = 34

    var font: Font {
        .system(size: self.rawValue)
    }
}

struct AppText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color.purple, radius: 2, x: 0, y: 3)
    }
}

struct FilledButtonStyle: ButtonStyle {
    var background: Color = .blue
    var foreground: Color = .white

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
//            .frame(maxWidth: .infinity)
            .background(background.opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(foreground)
            .cornerRadius(10)
    }
}
