//
//  AnimalCategoriesFeature.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 18.01.2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct AnimalCategoriesFeature {
    
    private struct Constants {
        static var okTitle = "OK"
        static var cancelTitle = "Cancel"
        static var watchAdTitle =  "Watch ad"
        static var comingSoonTitle = "Coming Soon"
        
        static var timerSleep: CGFloat = 2
    }
    
    struct State: Equatable {
        var categories: IdentifiedArrayOf<AnimalCategory> = []
        var isLoading: Bool = false
        var categoriesIsLoaded: Bool = false
        var errorMessage: String?
        
        @PresentationState var animalDetails: AnimalDetailsFeature.State?
        @PresentationState var alert: AlertState<Action.Alert>?
        var selectedCategory: AnimalCategory?
        var adIsShowed: Bool = false
    }
    
    enum Action {
        case requestStart
        case requestSuccess(IdentifiedArrayOf<AnimalCategory>)
        case requestFailure(Error)
        case sortArray(IdentifiedArrayOf<AnimalCategory>)
        case requestFinish(IdentifiedArrayOf<AnimalCategory>)
        
        case cardTapped(UUID)
        case animalDetails(PresentationAction<AnimalDetailsFeature.Action>)
        case alert(PresentationAction<Alert>)
        case showPaidAlert
        case showCominSoonAlert
        case adWatched
        
        enum Alert: Equatable {
            case cancel
            case ok
            case watchAd
        }
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
            case .cardTapped(let id):
                guard let animalCategory = state.categories[id: id] else { return .none }
                state.selectedCategory = animalCategory
                switch animalCategory.status {
                case .paid:
                    return .send(.showPaidAlert)
                case .free:
                    state.animalDetails = AnimalDetailsFeature.State(category: animalCategory)
                    return .none
                case .comingSoon:
                    return .send(.showCominSoonAlert)
                }
            case .animalDetails(_):
                return .none
                
            case .showPaidAlert:
                state.alert = AlertState {
                    TextState(Constants.watchAdTitle)
                } actions: {
                    ButtonState(action: .cancel) {
                        TextState(Constants.cancelTitle)
                    }
                    ButtonState(action: .watchAd) {
                        TextState(Constants.watchAdTitle)
                    }
                }
                return .none
                
            case .showCominSoonAlert:
                state.alert = AlertState {
                    TextState(Constants.comingSoonTitle)
                } actions: {
                    ButtonState(action: .ok) {
                        TextState(Constants.okTitle)
                    }
                }
                return .none
                
            case let .alert(.presented(action)):
                switch action {
                case .cancel, .ok:
                    return .none
                case .watchAd:
                    state.adIsShowed = true
                    return .run { send in
                        try await Task.sleep(for: .seconds(Constants.timerSleep))
                        await send(.adWatched)
                    }
                }
            case .alert:
                return .none
                
            case .adWatched:
                state.adIsShowed = false
                if let selectedCategory = state.selectedCategory {
                    state.animalDetails = AnimalDetailsFeature.State(category: selectedCategory)
                }
                return .none
            }
        }
        .ifLet(\.$animalDetails, action: \.animalDetails) {
            AnimalDetailsFeature()
                ._printChanges()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
