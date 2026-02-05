//
//  MainTabView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        let catalog = UINavigationController(rootViewController: CatalogViewController())
        catalog.tabBarItem = UITabBarItem(title: "Catalog", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let cart = UINavigationController(rootViewController: CartViewController())
        cart.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [catalog, cart, profile]
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()

        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        appearance.backgroundEffect = nil

        appearance.selectionIndicatorImage = UIImage()

        let itemAppearance = UITabBarItemAppearance()

   
        itemAppearance.normal.iconColor = .lightGray
        itemAppearance.selected.iconColor = .black

        itemAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.lightGray
        ]
        itemAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        itemAppearance.normal.badgeBackgroundColor = .systemGray4
        itemAppearance.normal.badgeTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 11, weight: .bold)
        ]

        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance

        tabBar.isTranslucent = false
        tabBar.clipsToBounds = false

        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBar.layer.shadowRadius = 4
    }

    
}
