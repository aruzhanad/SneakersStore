//
//  WelcomeView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let gradientBackgroundView = UIView()
    
    private let leftShoe: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "blackpair"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let rightShoe: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "coolpair"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the biggest sneakers store app"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 14
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("I already have an account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        [gradientBackgroundView, leftShoe, rightShoe, titleLabel, signUpButton, loginButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gradientBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            signUpButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -12),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),

            titleLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            leftShoe.topAnchor.constraint(equalTo: view.topAnchor, constant: 312),
            leftShoe.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -184),
            leftShoe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -22),
            leftShoe.widthAnchor.constraint(equalToConstant: 228),
            leftShoe.heightAnchor.constraint(equalToConstant: 228),

            rightShoe.topAnchor.constraint(equalTo: view.topAnchor, constant: 350), 
            rightShoe.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 51),
            rightShoe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 192),
            rightShoe.widthAnchor.constraint(equalToConstant: 246),
            rightShoe.heightAnchor.constraint(equalToConstant: 246)
        ])
    }
    
    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func signUpTapped() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func loginTapped() {
         let vc = LoginViewController()
         navigationController?.pushViewController(vc, animated: true)
    }
}
