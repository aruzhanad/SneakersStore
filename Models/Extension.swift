//
//  Extension.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 27.01.2026.
//

import UIKit

extension UITextField {
    static func createCustomField(placeholder: String, isSecure: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = isSecure
        tf.autocapitalizationType = .none
        return tf
    }
}
