//
//  Sneakers.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 02.02.2026.
//

import UIKit

struct Sneakers: Hashable {
    let id = UUID()
    let sneakerImage: UIImage
    let sneakerName: String
    let price: Int
    let description: String
    


    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Sneakers, rhs: Sneakers) -> Bool {
        return lhs.id == rhs.id
    }
}
