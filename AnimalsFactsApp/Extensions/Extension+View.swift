//
//  Extension+View.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 19.01.2024.
//

import SwiftUI

extension View {
    func loadingView(isLoading: Bool) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
    
    func errorView(errorMessage: String?) -> some View {
        self.modifier(ErrorViewModifier(errorMessage: errorMessage))
    }
    
    func comingSoonModifier(value: Bool) -> some View {
        self.modifier(ComingSoonViewModifier(value: value))
    }
    
    func showAdModifier(_ value: Bool) -> some View {
        self.modifier(AdViewModifier(showAd: value))
    }
}
