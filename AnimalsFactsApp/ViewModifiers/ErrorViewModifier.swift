//
//  ErrorViewModifier.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import SwiftUI

struct ErrorViewModifier: ViewModifier {
    let errorMessage: String?
    
    func body(content: Content) -> some View {
        if let error = errorMessage {
            Text("Ooops, we have an error: \(error)")
                .font(.title2)
                .foregroundColor(.red)
                .padding()
                .background(Color.black.opacity(0.3))
                .cornerRadius(10)
        } else {
            content
        }
    }
}
