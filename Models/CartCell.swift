//
//  CartCell.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 02.02.2026.
//

import UIKit

final class CartCell: UITableViewCell {
    static let identifier = "CartCell"
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let quantityLabel = UILabel()
    private let stepper = UIStepper()
    
    var onQuantityChange: ((Int) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        imgView.contentMode = .scaleAspectFit
        titleLabel.font = .boldSystemFont(ofSize: 16)
        priceLabel.textColor = .systemGray
        
        stepper.addTarget(self, action: #selector(stepperTapped), for: .valueChanged)
        
        let labelStack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 4
        
        let mainStack = UIStackView(arrangedSubviews: [imgView, labelStack, quantityLabel, stepper])
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imgView.widthAnchor.constraint(equalToConstant: 70),
            imgView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

    @objc private func stepperTapped() {
        onQuantityChange?(Int(stepper.value))
    }

    func configure(with sneaker: Sneakers, quantity: Int) {
        imgView.image = sneaker.sneakerImage
        titleLabel.text = sneaker.sneakerName
        priceLabel.text = "$\(sneaker.price)"
        quantityLabel.text = "\(quantity)"
        stepper.value = Double(quantity)
    }
}
