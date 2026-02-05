//
//  CartItem.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit


final class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [Sneakers: Int] = [:]
    
    func add(_ sneaker: Sneakers) {
        cartItems[sneaker, default: 0] += 1
    }
    
    func removeCompletely(_ sneaker: Sneakers) {
        cartItems.removeValue(forKey: sneaker)
    }
    
    var totalPrice: Int {
        return cartItems.reduce(0) { $0 + ($1.key.price * $1.value) }
    }
    
    var totalCount: Int {
        return cartItems.values.reduce(0, +)
    }
}
