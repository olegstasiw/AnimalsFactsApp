//
//  CategoryContent.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 19.01.2024.
//

import Foundation

struct CategoryContent: Decodable, Equatable, Identifiable {
    let id: UUID
    let fact: String
    let image: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fact = try container.decode(String.self, forKey: .fact)
        image = try container.decode(String.self, forKey: .image)
        
        id = UUID()
    }
    
    init(fact: String, image: String) {
        self.fact = fact
        self.image = image
        self.id = UUID()
    }
    
    private enum CodingKeys: String, CodingKey {
        case fact, image
    }
}
