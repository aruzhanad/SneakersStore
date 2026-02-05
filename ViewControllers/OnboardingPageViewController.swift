//
//  OnboardingPageViewController.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//

import UIKit

final class OnboardingPageViewController: UIViewController {

    private var currentIndex = 0
    private let imageView1 = UIImageView()
    private let imageView2 = UIImageView()

    private let bottomCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 10
        return view
    }()

    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let pageControl = UIPageControl()
    private let nextButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        updateContent()
    }

    private func setupUI() {
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center

        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        pageControl.numberOfPages = onboardingItems.count
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray

        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 14
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        [imageView1, imageView2, bottomCardView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        [pageControl, titleLabel, descriptionLabel, nextButton].forEach {
            bottomCardView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 37),
            imageView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -52),
            imageView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -44),
            imageView1.widthAnchor.constraint(equalToConstant: 398),
            imageView1.heightAnchor.constraint(equalToConstant: 532),
            
            imageView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 211),
            imageView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageView2.widthAnchor.constraint(equalToConstant: 272),
            imageView2.heightAnchor.constraint(equalToConstant: 192),

            
            bottomCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomCardView.heightAnchor.constraint(equalToConstant: 260),

            
            pageControl.topAnchor.constraint(equalTo: bottomCardView.topAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: bottomCardView.centerXAnchor),

            
            titleLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: bottomCardView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: bottomCardView.trailingAnchor, constant: -24),

            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

           
            nextButton.bottomAnchor.constraint(equalTo: bottomCardView.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextButton.leadingAnchor.constraint(equalTo: bottomCardView.leadingAnchor, constant: 24),
            nextButton.trailingAnchor.constraint(equalTo: bottomCardView.trailingAnchor, constant: -24),
            nextButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func updateContent() {
        let item = onboardingItems[currentIndex]
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve) {
            self.imageView1.image = UIImage(named: item.image1)
            self.imageView2.image = UIImage(named: item.image2)
            self.titleLabel.text = item.title
            self.descriptionLabel.text = item.description
        }
        pageControl.currentPage = currentIndex
        let title = currentIndex == onboardingItems.count - 1 ? "Finish" : "Next"
        nextButton.setTitle(title, for: .normal)
    }

    @objc private func nextTapped() {
        if currentIndex < onboardingItems.count - 1 {
            currentIndex += 1
            updateContent()
        } else {
            finishOnboarding()
        }
    }

    private func finishOnboarding() {
        let welcomeVC = WelcomeViewController()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}



