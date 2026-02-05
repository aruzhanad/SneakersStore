//
//  Sneakers.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class SneakerCell: UICollectionViewCell {
    static let identifier = "SneakerCell"
    


    private var sneaker: Sneakers?
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    
    var isInCart = false {
        didSet { updateButtonState() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) { fatalError() }

    private func setupCellLayout() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        nameLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 2
        priceLabel.font = .boldSystemFont(ofSize: 14)
        
        actionButton.layer.cornerRadius = 15
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        actionButton.addTarget(self, action: #selector(cartTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [imageView, nameLabel, descriptionLabel, priceLabel, actionButton])
        stack.axis = .vertical
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 110),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func updateButtonState() {
        actionButton.setTitle(isInCart ? "Remove" : "Add to cart", for: .normal)
        actionButton.backgroundColor = isInCart ? .darkGray : .black
    }

    @objc private func cartTapped() {
        guard let sneaker = sneaker else { return }
        
        if isInCart {
            CartManager.shared.removeCompletely(sneaker)
        } else {
            CartManager.shared.add(sneaker)
        }
        
        isInCart.toggle()
        

        if let tabBar = self.window?.rootViewController as? UITabBarController {
            let count = CartManager.shared.totalCount
            tabBar.tabBar.items?[1].badgeValue = count > 0 ? "\(count)" : nil
        }
    }

    func configure(with sneaker: Sneakers) {
        self.sneaker = sneaker
        imageView.image = sneaker.sneakerImage
        nameLabel.text = sneaker.sneakerName
        descriptionLabel.text = sneaker.description
        priceLabel.text = "$\(sneaker.price)"
        
        isInCart = CartManager.shared.cartItems[sneaker] != nil
    }
}
