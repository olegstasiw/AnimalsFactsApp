//
//  AnimalFactCardView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import SwiftUI

struct AnimalFactCardView: View {
    
    private struct Constants {
        static var contentPadding: CGFloat = 20
    }
    
    var animalFact: CategoryContent
    var screenSize: CGSize
    var padding: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: animalFact.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.4)
                    ProgressView()
                }
            }
            .frame(width: screenSize.width - Constants.contentPadding - padding,
                   height: screenSize.height / 3)
            .clipped()
            .padding(Constants.contentPadding / 2)
            
            Text(animalFact.fact)
                .lineLimit(nil)
                .foregroundStyle(.black)
                .font(.contentFont)
                .padding(Constants.contentPadding / 2)
                .minimumScaleFactor(0.01)
            Spacer()
        }
    }
}

#Preview {
    AnimalFactCardView(animalFact: CategoryContent(fact: "Fact 1", image: "url"), screenSize: CGSize(width: 400, height: 900), padding: 40)
}
