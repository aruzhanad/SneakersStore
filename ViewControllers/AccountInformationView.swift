//
//  AccountInformation.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 04.02.2026.
//

import UIKit

class AccountInformationView: UIViewController {
        
    private lazy var usernameField = createInformation(placeholder: "unique_username")
    private lazy var passwordField = createInformation(placeholder: "paSs_Wo!!Rd", isSecure: true)
    private lazy var confirmPasswordField = createInformation(placeholder: "paSsWo!!Rd", isSecure: true)
    
    
    
    private let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save Changes", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 18)
        btn.layer.cornerRadius = 25
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Account Information"
        
        setupUI()
    }
    
    private func setupUI() {
        
        let stackView = UIStackView(arrangedSubviews: [usernameField, passwordField, confirmPasswordField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 180),

            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor
                                                , constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
     
    private func createInformation(placeholder: String, isSecure: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.isSecureTextEntry = isSecure
        tf.font = .systemFont(ofSize: 17)
        tf.backgroundColor = UIColor(white: 0.96, alpha: 1.0)
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        tf.clearButtonMode = .whileEditing
        return tf
    }
        
    }
    
 
    
    
    
    



