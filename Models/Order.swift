//
//  Order.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

struct Order {
    let id: String
    let date: Date
    let totalPrice: Int
    let items: [Sneakers: Int]
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

final class OrderHistoryManager {
    static let shared = OrderHistoryManager()
    var orders: [Order] = []
    
    func createOrder(from cartItems: [Sneakers: Int], total: Int) {
        let newOrder = Order(
            id: "#\(Int.random(in: 1000...9999))",
            date: Date(),
            totalPrice: total,
            items: cartItems
        )
        orders.insert(newOrder, at: 0) 
    }
}
