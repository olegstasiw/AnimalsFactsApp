//
//  AnimalCategoriesFeature.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import ComposableArchitecture

@Reducer
struct AnimalCategoriesFeature {
    struct State: Equatable {
        var categories: IdentifiedArrayOf<AnimalCategory> = []
        var isLoading: Bool = false
        var categoriesIsLoaded: Bool = false
        var errorMessage: String?
    }
    
    enum Action {
        case requestStart
        case requestSuccess(IdentifiedArrayOf<AnimalCategory>)
        case requestFailure(Error)
        case sortArray(IdentifiedArrayOf<AnimalCategory>)
        case requestFinish(IdentifiedArrayOf<AnimalCategory>)
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .requestStart:
                guard !state.categoriesIsLoaded else { return .none }
                state.isLoading = true
                return .run { send in
                    do {
                        let result = try await networkManager.fetchAnimalCategories()
                        await send(.requestSuccess(result))
                    } catch {
                        await send(.requestFailure(error))
                    }
                }
            case .requestSuccess(let unsortedData):
                return .run { send in
                    await send(.sortArray(unsortedData))
                }
            case .sortArray(let unsortedData):
                let sortedArray = unsortedData.sorted { $0.order < $1.order }
                return .run { send in
                    await send(.requestFinish(IdentifiedArrayOf(uniqueElements: sortedArray)))
                }
            case .requestFinish(let finishData):
                state.categories = finishData
                state.isLoading = false
                state.categoriesIsLoaded = true
                return .none
            case .requestFailure(let error):
                state.errorMessage = error.localizedDescription
                state.isLoading = false
                state.categoriesIsLoaded = false
                return .none
            }
        }
    }
}
