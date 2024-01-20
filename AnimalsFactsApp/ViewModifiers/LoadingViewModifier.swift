//
//  LoadingViewModifier.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import SwiftUI

struct LoadingViewModifier: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        if isLoading {
            ProgressView()
                .controlSize(.large)
        } else {
            content
        }
    }
}
