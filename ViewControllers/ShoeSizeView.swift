//
//  ShoeSizeView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 04.02.2026.
//

import UIKit

final class ShoeSizeView: UIViewController {
    
    
    private let shoeSizeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "41,5"
        tf.font = .systemFont(ofSize: 17, weight: .semibold)
        tf.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        tf.layer.cornerRadius = 8
        tf.keyboardType = .decimalPad
        tf.translatesAutoresizingMaskIntoConstraints = false
      
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        return tf

    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Shoe Size"
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(shoeSizeTextField)
        
        
        NSLayoutConstraint.activate([
            shoeSizeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            shoeSizeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shoeSizeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            shoeSizeTextField.heightAnchor.constraint(equalToConstant: 60)

        ])
    }
}
