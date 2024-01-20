//
//  AnimalsFactsAppApp.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 17.01.2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct AnimalsFactsAppApp: App {
    var body: some Scene {
        WindowGroup {
            AnimalCategoriesView(store: Store(initialState: AnimalCategoriesFeature.State()) {
                AnimalCategoriesFeature()
            })
        }
    }
}
