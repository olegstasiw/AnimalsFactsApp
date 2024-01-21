//
//  ControlsButtonView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import SwiftUI

enum ControlsButtonType {
    case back
    case forward
    
    var image: UIImage {
        switch self {
        case .back:
            return .arrowBack
        case .forward:
            return .arrowForward
        }
    }
}

struct ControlsButtonView: View {
    
    private struct Constants {
        static var buttonSize: CGFloat = 52
        static var buttonPadding: CGFloat = 20
    }
    
    var type: ControlsButtonType
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(uiImage: type.image).renderingMode(.template)
                .tint(.black)
        }
        .frame(width: Constants.buttonSize, height: Constants.buttonSize)
        .padding(Constants.buttonPadding)
    }
}

#Preview {
    ControlsButtonView(type: .back, action: {})
}
