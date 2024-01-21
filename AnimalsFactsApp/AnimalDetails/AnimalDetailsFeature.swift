//
//  AnimalDetailsFeature.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 20.01.2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AnimalDetailsFeature {
    struct State: Equatable {
        var category: AnimalCategory
        var selectedPage: Int = 0
        var shareShowed = false
        
        var facts: [CategoryContent] {
            return category.content ?? []
        }
        
        var selectedContent: CategoryContent? {
            return facts[safe: selectedPage]
        }
    }
    
    enum Action {
        case pageChanged(Int)
        case showNext
        case showPrevious
        case dismiss
        case shareShowed
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .pageChanged(let sel):
                state.selectedPage = sel
                return .none
            case .showNext:
                guard state.facts.count != state.selectedPage + 1 else {
                    return .none
                }
                state.selectedPage += 1
                return .none
            case .showPrevious:
                guard state.selectedPage != 0 else {
                    return .none
                }
                state.selectedPage -= 1
                return .none
            case .dismiss:
                return .run { _ in
                    await self.dismiss()
                }
            case .shareShowed:
                state.shareShowed.toggle()
                return .none
            }
        }
    }
}
