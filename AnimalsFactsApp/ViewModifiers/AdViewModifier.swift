//
//  AdViewModifier.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import SwiftUI

struct AdViewModifier: ViewModifier {
    var showAd: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if showAd {
                ProgressView()
                    .controlSize(.large)
                    .padding(50)
                    .tint(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
        }
    }
}

