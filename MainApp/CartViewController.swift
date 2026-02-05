//
//  CartView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private let totalLabel = UILabel()
    private let confirmButton = UIButton(type: .system)
    
    private var itemsArray: [(sneaker: Sneakers, qty: Int)] {
        return CartManager.shared.cartItems.map { ($0.key, $0.value) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Cart"
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateTotal()
    }

    private func setupLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        tableView.separatorStyle = .none
        
        totalLabel.font = .boldSystemFont(ofSize: 20)
        confirmButton.backgroundColor = .black
        confirmButton.setTitle("Confirm Order", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 25
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
        
        let bottomView = UIView()
        bottomView.backgroundColor = .systemGray6
        
        [tableView, bottomView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        bottomView.addSubview(totalLabel)
        bottomView.addSubview(confirmButton)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 120),
            
            totalLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15),
            totalLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            
            confirmButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 10),
            confirmButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func updateTotal() {
        totalLabel.text = "Total: $\(CartManager.shared.totalPrice)"
        navigationController?.tabBarItem.badgeValue = CartManager.shared.totalCount > 0 ? "\(CartManager.shared.totalCount)" : nil
    }

    @objc private func didTapConfirm() {
        let alert = UIAlertController(title: "Order", message: "Confirm your order?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default) { _ in
            
            OrderHistoryManager.shared.createOrder(
                from: CartManager.shared.cartItems,
                total: CartManager.shared.totalPrice
            )
            
            let successVC = SuccessViewController()
            successVC.modalPresentationStyle = .fullScreen
            self.present(successVC, animated: true)
        })
        present(alert, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier, for: indexPath) as! CartCell
        let item = itemsArray[indexPath.row]
        cell.configure(with: item.sneaker, quantity: item.qty)
        
        cell.onQuantityChange = { newQty in
            if newQty == 0 {
                CartManager.shared.removeCompletely(item.sneaker)
            } else {
                CartManager.shared.cartItems[item.sneaker] = newQty
            }
            tableView.reloadData()
            self.updateTotal()
        }
        return cell
    }
}
