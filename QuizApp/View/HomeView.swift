//
//  HomeView.swift
//  QuizApp
//
//  Created by Meenakshi Pathani on 14/06/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            
            ZStack() {
                GradientBackground()
                
                VStack(spacing: 50) {
                    
                    AppText(text: "Welcome to the quiz!", size: AppFontSize.large.rawValue)
                    
                    NavigationLink(destination: QuizView()){
                        
                        Text("Start Quiz")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
