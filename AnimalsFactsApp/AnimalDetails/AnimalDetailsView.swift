//
//  AnimalDetailsView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 20.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalDetailsView: View {
    
    private struct Constants {
        static var contentPadding: CGFloat = 40
        static var navigationBarIconSize: CGFloat = 20
    }
    
    let store: StoreOf<AnimalDetailsFeature>
    @State var selectedPage = 0
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                VStack {
                    AnimalsFactsCarouselView(facts: viewStore.facts,
                                             selectedPage: $selectedPage,
                                             screenSize: proxy.size,
                                             padding: Constants.contentPadding)
                    Spacer()
                    HStack {
                        ControlsButtonView(type: .back) {
                            viewStore.send(.showPrevious)
                        }
                        .disabled(viewStore.selectedPage == 0)
                        Spacer()
                        ControlsButtonView(type: .forward) {
                            viewStore.send(.showNext)
                        }
                        .disabled(viewStore.selectedPage == viewStore.facts.count - 1)
                    }
                }
                .background(Color.white)
                .frame(height: proxy.size.height * 0.75)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .padding(Constants.contentPadding / 2)
                .shadow(color: Color.black.opacity(0.3), radius: 60, x: 0, y: 20)
                .onChange(of: selectedPage) { value in
                    viewStore.send(.pageChanged(value))
                }
                .onChange(of: viewStore.selectedPage) { value in
                    selectedPage = value
                }
            }
            .navigationTitle(viewStore.category.title)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                viewStore.send(.dismiss)
            }, label: {
                Image(.backArrowIcon)
                    .foregroundStyle(.black)
                    .frame(width: Constants.navigationBarIconSize,
                           height: Constants.navigationBarIconSize)
            }), trailing:
                                    Button(action: {
                viewStore.send(.shareShowed)
            }, label: {
                Image.shareImage
                    .foregroundStyle(.black)
                    .frame(width: Constants.navigationBarIconSize,
                           height: Constants.navigationBarIconSize)
            }))
            .sheet(isPresented: viewStore.binding(get: \.shareShowed, send: .shareShowed)) {
                let text = viewStore.selectedContent?.fact ?? ""
                ShareView(activityItems: [text])
            }
        }
        .background(Color.backgroundBase)
    }
}

#Preview {
    AnimalDetailsView(store: Store(
        initialState: AnimalDetailsFeature.State(
            category: AnimalCategory(title: "Test title",
                                     description: "Test description",
                                     image: "url",
                                     order: 1,
                                     status: .free,
                                     content: [CategoryContent(fact: "fact 1", image: "URL"), CategoryContent(fact: "fact 2", image: "URL")]))
    ) {
        AnimalDetailsFeature()
    })
}
