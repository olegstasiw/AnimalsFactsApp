//
//  Extension+Array.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 21.01.2024.
//

import Foundation

extension Array {
    subscript (safe index:Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
