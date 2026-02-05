//
//  User.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

struct User: Identifiable{
    var id: String = UUID().uuidString
    let email: String
    let username: String?
    let password: String
}
