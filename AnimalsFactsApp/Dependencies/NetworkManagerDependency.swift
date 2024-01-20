//
//  NetworkManagerDependency.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import ComposableArchitecture
import SwiftUI

struct NetworkManagerDependency {
    var fetchAnimalCategories: () async throws -> IdentifiedArrayOf<AnimalCategory>
}

extension NetworkManagerDependency: DependencyKey {
    static let liveValue = Self(
        fetchAnimalCategories: {
            guard let url = URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json") else {
                return []
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let results = try JSONDecoder().decode([AnimalCategory].self, from: data)
            return IdentifiedArrayOf(uniqueElements: results)
        }
    )
}

extension DependencyValues {
    var networkManager: NetworkManagerDependency {
        get { self[NetworkManagerDependency.self] }
        set { self[NetworkManagerDependency.self] = newValue }
    }
}
