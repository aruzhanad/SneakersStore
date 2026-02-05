//
//  ProfileView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit
import SafariServices

final class ProfileViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    

    private let accountInfoRow = ProfileRowView(title: "Account Information", showChevron: true)
    private let orderHistoryRow = ProfileRowView(title: "Order History", showChevron: true)
    private let shoeSizeRow = ProfileRowView(title: "Shoe size", detailText: "41,5", showChevron: true)
    

    private let sizeGuideRow = ProfileRowView(title: "How to know your shoe size?", isExternal: true)
    private let authenticityRow = ProfileRowView(title: "How to check the authenticity of the shoe?", isExternal: true)
    
    private let signOutButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign out", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 30
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        title = "Profile"
        setupLayout()
        setupActions()
    }
    
    private func setupActions() {
        accountInfoRow.isUserInteractionEnabled = true
        accountInfoRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAccountInfo)))
        
        orderHistoryRow.isUserInteractionEnabled = true
        orderHistoryRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
            #selector(openOrderHistory)))
        
        
        shoeSizeRow.isUserInteractionEnabled = true
        shoeSizeRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action:
            #selector(openShoeSize)))
        
        
        sizeGuideRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSizeGuide)))
        authenticityRow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAuthenticityGuide)))
        signOutButton.addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(signOutButton)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        let topSection = createCardStack(views: [accountInfoRow, Divider(), orderHistoryRow, Divider(), shoeSizeRow])
        let bottomSection = createCardStack(views: [sizeGuideRow, Divider(), authenticityRow])
        
        stackView.addArrangedSubview(topSection)
        stackView.addArrangedSubview(bottomSection)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signOutButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func createCardStack(views: [UIView]) -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 12
        
        let subStack = UIStackView(arrangedSubviews: views)
        subStack.axis = .vertical
        subStack.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(subStack)
        NSLayoutConstraint.activate([
            subStack.topAnchor.constraint(equalTo: container.topAnchor),
            subStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            subStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            subStack.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}


final class ProfileRowView: UIView {
    init(title: String, detailText: String? = nil, showChevron: Bool = false, isExternal: Bool = false) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 17)
        
        let rightView = UIStackView()
        rightView.spacing = 8
        
        if let detail = detailText {
            let detailLabel = UILabel()
            detailLabel.text = detail
            detailLabel.textColor = .systemGray
            rightView.addArrangedSubview(detailLabel)
        }
        
        if showChevron {
            let img = UIImageView(image: UIImage(systemName: "chevron.right"))
            img.tintColor = .systemGray3
            img.contentMode = .scaleAspectFit
            rightView.addArrangedSubview(img)
        }
        
        if isExternal {
            let img = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
            img.tintColor = .systemGray3
            img.contentMode = .scaleAspectFit
            rightView.addArrangedSubview(img)
        }
        
        addSubview(label)
        addSubview(rightView)
        label.translatesAutoresizingMaskIntoConstraints = false
        rightView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            rightView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) { fatalError() }
}

final class Divider: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    required init?(coder: NSCoder) { fatalError() }
}


extension ProfileViewController {
    @objc private func openAccountInfo(){
        let accountVC = AccountInformationView()
        
        navigationController?.pushViewController(accountVC, animated: true)
    }
    
    
    @objc private func openOrderHistory(){
        let orderVC = OrderHistoryViewController()
        
        navigationController?.pushViewController(orderVC, animated: true)
    }
    
    
    @objc private func openShoeSize(){
        let shoeSizeVC = ShoeSizeView()
        
        navigationController?.pushViewController(shoeSizeVC, animated: true)
    }
    
    @objc private func openSizeGuide() {
        let url = URL(string: "https://www.nike.com/size-fit/mens-footwear")!
        present(SFSafariViewController(url: url), animated: true)
    }
    
    @objc private func openAuthenticityGuide() {
        let url = URL(string: "https://legitcheck.app")!
        present(SFSafariViewController(url: url), animated: true)
    }
    
    @objc private func handleSignOut() {
            let alert = UIAlertController(title: "Sign Out", message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in

                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    let welcomeVC = UINavigationController(rootViewController: WelcomeViewController())
                    sceneDelegate.window?.rootViewController = welcomeVC
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
    }

