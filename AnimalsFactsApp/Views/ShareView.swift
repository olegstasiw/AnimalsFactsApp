//
//  ShareView.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
