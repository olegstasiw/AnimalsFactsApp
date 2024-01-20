//
//  AnimalCategoryView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 19.01.2024.
//

import SwiftUI

struct AnimalCategoryView: View {
    
    private struct Constants {
        static let cardHeight: CGFloat = 120
        static let cardVerticalPadding: CGFloat = 8
        static let cardHorizontalPadding: CGFloat = 20
        static let spaceBetweenContent: CGFloat = 12
        static let imagePadding: CGFloat = 5
        static let contentTopPadding: CGFloat = 10
        static let contentBottomPadding: CGFloat = 7
        static let contentTrailingPadding: CGFloat = 5
        
        static let premiumText = "Premium"
    }
    
    var category: AnimalCategory
    var screenWidth: CGFloat
    
    var body: some View {
        ZStack {
            Color.white
            HStack(spacing: Constants.spaceBetweenContent) {
                AsyncImage(url: URL(string: category.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.gray
                            .opacity(0.4)
                        ProgressView()
                    }
                }
                .frame(width: screenWidth / 3,
                       height: Constants.cardHeight - (Constants.imagePadding * 2))
                .clipped()
                .padding(Constants.imagePadding)
                
                VStack(alignment: .leading) {
                    Text(category.title)
                        .font(.titleFont)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.black)
                    Text(category.description)
                        .font(.descriptionFont)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.black)
                        .opacity(0.5)
                    Spacer()
                    if category.status == .paid {
                        HStack {
                            Image.lockIcon
                            Text(Constants.premiumText)
                        }
                        .foregroundStyle(Color.highlightedBlue)
                    }
                }
                .padding(EdgeInsets(top: Constants.contentTopPadding,
                                    leading: 0,
                                    bottom: Constants.contentBottomPadding,
                                    trailing: Constants.contentTrailingPadding))
                Spacer()
            }
        }
        .comingSoonModifier(value: category.status == .comingSoon)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .frame(maxHeight: Constants.cardHeight)
        .padding(.horizontal, Constants.cardHorizontalPadding)
        .padding(.vertical, Constants.cardVerticalPadding)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        AnimalCategoryView(category: AnimalCategory(title: "Test title",
                                                    description: "Test description",
                                                    image: "url",
                                                    order: 1,
                                                    status: .free,
                                                    content: []),
                           screenWidth: 400)
        AnimalCategoryView(category: AnimalCategory(title: "Test title",
                                                    description: "Test description",
                                                    image: "url",
                                                    order: 1,
                                                    status: .paid,
                                                    content: []),
                           screenWidth: 400)
        AnimalCategoryView(category: AnimalCategory(title: "Test title",
                                                    description: "Test description",
                                                    image: "url",
                                                    order: 1,
                                                    status: .comingSoon,
                                                    content: []),
                           screenWidth: 400)
    }
}
