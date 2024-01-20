//
//  ComingSoonViewModifier.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 19.01.2024.
//

import SwiftUI

struct ComingSoonViewModifier: ViewModifier {
    let value: Bool
    
    func body(content: Content) -> some View {
        if value {
            content
                .overlay {
                    ZStack {
                        Color.black
                            .opacity(0.6)
                        HStack {
                            Spacer()
                            Image(.comingSoon)
                        }
                    }
                    .clipped()
                }
        } else {
            content
        }
    }
}
