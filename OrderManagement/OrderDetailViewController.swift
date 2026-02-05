//
//  OrderDetailView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class OrderDetailViewController: UIViewController, UITableViewDataSource {
    private let order: Order
    private let tableView = UITableView()

    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = order.id
        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        let label = UILabel(frame: header.bounds.insetBy(dx: 20, dy: 10))
        label.numberOfLines = 0
        label.text = "Placed on: \(order.formattedDate)\nTotal Amount: $\(order.totalPrice)"
        label.font = .systemFont(ofSize: 16)
        view.addSubview(header)
        tableView.tableHeaderView = header
    }

    private func setupTableView() {
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return order.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = Array(order.items.keys)[indexPath.row]
        let qty = order.items[item] ?? 0
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = item.sneakerName
        cell.detailTextLabel?.text = "Quantity: \(qty) | Price: $\(item.price)"
        cell.imageView?.image = item.sneakerImage
        return cell
    }
}
