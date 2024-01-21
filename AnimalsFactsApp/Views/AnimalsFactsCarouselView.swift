//
//  AnimalsFactsCarouselView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import SwiftUI

struct AnimalsFactsCarouselView: View {
    var facts: [CategoryContent]
    @Binding var selectedPage: Int
    var screenSize: CGSize
    var padding: CGFloat
    
    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                ForEach(facts.indices, id: \.self) { index in
                    AnimalFactCardView(animalFact: facts[index], screenSize: screenSize, padding: padding)
                        .tag(index)
                }
            }
            .animation(.linear, value: self.selectedPage)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

#Preview {
    AnimalsFactsCarouselView(facts: [CategoryContent(fact: "Fact 1", image: "Url"),
                                     CategoryContent(fact: "Fact 2", image: "Url")], selectedPage: .constant(0), screenSize: CGSize(width: 400, height: 900), padding: 40)
}
