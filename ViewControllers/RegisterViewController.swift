//
//  RegistrationView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    private let usernameField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    
    private let signUpButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    private let loginShortcutButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: "Login",
                                                 attributes: [.foregroundColor: UIColor.black, .font: UIFont.boldSystemFont(ofSize: 14)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private let viewModel = AuthViewModel()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "New User"
        
        setupRegistration()
        setupNavigation()
        setupActions()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    

        private func setupNavigation() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backToOnboarding))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        loginShortcutButton.addTarget(self, action: #selector(handleLoginShortcut), for: .touchUpInside)
        
        
        [usernameField, emailField, passwordField].forEach{
            $0.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        }
    }

    @objc private func validateFields() {
        let username = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordField.text ?? ""

        let isFormValid = !username.isEmpty && !email.isEmpty && !password.isEmpty
        
        signUpButton.isEnabled = isFormValid
        signUpButton.alpha = isFormValid ? 1.0 : 0.5
        
        print("Form is valid: \(isFormValid)")
    }
    
    @objc private func backToOnboarding() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func handleLoginShortcut() {
        navigationController?.popViewController(animated: true)
        
         let loginVC = LoginViewController()
         navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc private func signUpTapped() {
        guard signUpButton.isEnabled else { return }
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let username = usernameField.text, !username.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields.")
            return
        }
        
        let newUser = User(email: email, username: username, password: password)
        
        viewModel.createNewUser(user: newUser) { [weak self] result in
            switch result {
            case .success(let success):
                if success {
                    self?.showAlert(title: "Success", message: "Verification email sent!") {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            case .failure(let error):
                self?.showAlert(title: "Registration Error", message: error.localizedDescription)
            }
        }    }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
           
            if signUpButton.isEnabled {
                signUpTapped()
            } else {
                view.endEditing(true) 
            }
        }
        return true
    }
    
    
    func setupRegistration() {
        let fields = [usernameField, emailField, passwordField]
        
        for field in fields {
            field.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
            field.layer.cornerRadius = 8
            field.translatesAutoresizingMaskIntoConstraints = false
            
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
            field.leftView = paddingView
            field.leftViewMode = .always
        }
        
        let stackView = UIStackView(arrangedSubviews: fields)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(signUpButton)
        view.addSubview(loginShortcutButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        loginShortcutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 180),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),
            
            loginShortcutButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 15),
            loginShortcutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        signUpButton.isEnabled = false
        signUpButton.alpha = 0.5
        usernameField.placeholder = "Username"
        usernameField.autocapitalizationType = .words
        
        emailField.placeholder = "Email"
        emailField.keyboardType = .emailAddress
        emailField.autocapitalizationType = .none
        
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .oneTimeCode 
        
        
    }
}
