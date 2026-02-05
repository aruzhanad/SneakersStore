//
//  SuccessOrderView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class SuccessViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = "Order Successful!"
        label.font = .boldSystemFont(ofSize: 24)
        
        let backBtn = UIButton(type: .system)
        backBtn.setTitle("Get back to shopping", for: .normal)
        backBtn.backgroundColor = .black
        backBtn.setTitleColor(.white, for: .normal)
        backBtn.layer.cornerRadius = 25
        backBtn.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [imageView, label, backBtn])
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            backBtn.widthAnchor.constraint(equalToConstant: 250),
            backBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func dismissModal() {


        CartManager.shared.cartItems.removeAll()
        dismiss(animated: true)
    }
}
