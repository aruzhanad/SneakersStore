//
//  OrderHistoryView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class OrderHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Order History"
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OrderHistoryCell.self, forCellReuseIdentifier: "OrderHistoryCell")
        tableView.rowHeight = 100
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderHistoryManager.shared.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryCell", for: indexPath) as! OrderHistoryCell
        cell.configure(with: OrderHistoryManager.shared.orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = OrderHistoryManager.shared.orders[indexPath.row]
        let detailVC = OrderDetailViewController(order: order)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


final class OrderHistoryCell: UITableViewCell {
    private let idLabel = UILabel()
    private let dateLabel = UILabel()
    private let priceLabel = UILabel()
    private let imageStack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        idLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.textColor = .gray
        priceLabel.font = .systemFont(ofSize: 14)
        imageStack.spacing = 5
        imageStack.distribution = .fillEqually
        
        let infoStack = UIStackView(arrangedSubviews: [idLabel, dateLabel, priceLabel])
        infoStack.axis = .vertical
        
        let mainStack = UIStackView(arrangedSubviews: [infoStack, imageStack])
        mainStack.axis = .horizontal
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageStack.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    func configure(with order: Order) {
        idLabel.text = "Order \(order.id)"
        dateLabel.text = order.formattedDate
        priceLabel.text = "Total: $\(order.totalPrice)"
        
        imageStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let sneakers = Array(order.items.keys).prefix(3)
        for sneaker in sneakers {
            let iv = UIImageView(image: sneaker.sneakerImage)
            iv.contentMode = .scaleAspectFit
            iv.layer.cornerRadius = 4
            iv.clipsToBounds = true
            iv.backgroundColor = .systemGray6
            imageStack.addArrangedSubview(iv)
        }
    }
}
