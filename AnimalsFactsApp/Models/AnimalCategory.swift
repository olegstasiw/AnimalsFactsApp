//
//  AnimalCategory.swift
//  AnimalsFactsApp
//
//  Created by Oleh Stasiv on 19.01.2024.
//

import Foundation

struct AnimalCategory: Decodable, Identifiable, Equatable {
    let id: UUID
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: CategoryStatus
    let content: [CategoryContent]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        image = try container.decode(String.self, forKey: .image)
        order = try container.decode(Int.self, forKey: .order)
        let categoryStatus = try container.decode(String.self, forKey: .status)
        content = try container.decodeIfPresent([CategoryContent].self, forKey: .content)
        status = content == nil ? .comingSoon : CategoryStatus(rawValue: categoryStatus) ?? .comingSoon
        
        id = UUID()
    }
    
    init(title: String, description: String, image: String, order: Int, status: CategoryStatus, content: [CategoryContent]) {
        self.title = title
        self.description = description
        self.image = image
        self.order = order
        self.status = status
        self.content = content
        self.id = UUID()
    }
    
    private enum CodingKeys: String, CodingKey {
        case title, description, image, order, status, content
    }
}
