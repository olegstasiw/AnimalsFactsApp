//
//  AnimalCategoriesView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct AnimalCategoriesView: View {
    
    private struct Constants {
        static let animalCategoriesViewTitle = "Animals facts"
    }
    
    let store: StoreOf<AnimalCategoriesFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                GeometryReader { proxy in
                    ZStack {
                        Color.backgroundBase
                            .ignoresSafeArea()
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(viewStore.categories) { category in
                                    Button {
                                        viewStore.send(.cardTapped(category.id))
                                    } label: {
                                        AnimalCategoryView(category: category, screenWidth: proxy.size.width)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                .navigationTitle(Constants.animalCategoriesViewTitle)
                .loadingView(isLoading: viewStore.isLoading)
                .errorView(errorMessage: viewStore.errorMessage)
                .showAdModifier(viewStore.adIsShowed)
                .task {
                    viewStore.send(.requestStart)
                }
                .navigationDestination(
                    store: self.store.scope(
                        state: \.$animalDetails,
                        action: \.animalDetails
                    ),
                    destination: { store in
                        AnimalDetailsView(store: store)
                    }
                )
                .alert(
                      store: self.store.scope(
                        state: \.$alert,
                        action: \.alert
                      )
                    )
            }
        }
    }
}

#Preview {
    AnimalCategoriesView(store: Store(initialState: AnimalCategoriesFeature.State()) {
        AnimalCategoriesFeature()
      }
    )
}
