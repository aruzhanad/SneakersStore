//
//  LoginView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit
final class LoginViewController: UIViewController {
    let emailField = UITextField()
    let passwordField = UITextField()
    private let viewModel = AuthViewModel()
    
    let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign in", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Welcome back!"
        setupLogin()
        setupActions()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        [emailField, passwordField].forEach {
            $0.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        }
    }
    
    @objc private func validateFields() {
        let isEmailEmpty = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        let isPasswordEmpty = passwordField.text?.isEmpty ?? true
        
        let isFormValid = !isEmailEmpty && !isPasswordEmpty
        
        signInButton.isEnabled = isFormValid
        signInButton.alpha = isFormValid ? 1.0 : 0.5
    }
    
    @objc private func signInTapped() {
        guard signInButton.isEnabled else { return }
        
        let mainTabBar = MainTabBarController()
        guard let window = view.window else { return }
        window.rootViewController = mainTabBar
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
    
    private func setupLogin() {
        let fields = [emailField, passwordField]
        
        for field in fields {
            field.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
            field.layer.cornerRadius = 8
            field.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
            field.leftView = paddingView
            field.leftViewMode = .always
        }
        
        passwordField.isSecureTextEntry = true
        
        let stackView = UIStackView(arrangedSubviews: fields)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        
        signInButton.isEnabled = false
        signInButton.alpha = 0.5
    }
}
