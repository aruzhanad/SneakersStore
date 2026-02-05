//
//  CatalogView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 26.01.2026.
//
import UIKit


final class CatalogViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var collectionView: UICollectionView!
    var sneakersData: [Sneakers] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray6
        title = "Catalog"
        setupCollectionView()
        loadSampleData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(SneakerCell.self, forCellWithReuseIdentifier: SneakerCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 15
        let width = (collectionView.frame.width - spacing) / 2
        return CGSize(width: width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sneakersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SneakerCell.identifier, for: indexPath) as! SneakerCell
        
        let sneaker = sneakersData[indexPath.row]
        cell.configure(with: sneaker)
        
        return cell
    }
}

extension CatalogViewController {
    func loadSampleData() {
        self.sneakersData = [
            Sneakers(sneakerImage: UIImage(named: "1stsneaker") ?? UIImage(),
                     sneakerName: "Dolce & Gabbana", price: 1251,
                     description: "Кеды с принтом граффити"),
            Sneakers(sneakerImage: UIImage(named: "2ndsneaker") ?? UIImage(),
                     sneakerName: "Off-White", price: 551,
                     description: "Кроссовки Off-Court 3.0"),
            Sneakers(sneakerImage: UIImage(named: "3rdsneaker") ?? UIImage(),
                     sneakerName: "Jordan", price: 1251,
                     description: "Кеды Jordan Retro"),
            Sneakers(sneakerImage: UIImage(named: "4thsneaker") ?? UIImage(),
                     sneakerName: "Nike", price: 1251,
                     description: "Air Force 1 Custom")
        ]
        collectionView.reloadData()
    }
}
