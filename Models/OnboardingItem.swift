//
//  OnboardingData.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 27.01.2026.
//
import UIKit

struct OnboardingItem: Identifiable{
    let id = UUID()
    let image1: String
    let image2: String
    let title: String
    let description: String
}

let onboardingItems: [OnboardingItem] = [
    OnboardingItem(image1: "greensneaker",
                   image2: "yellowsneaker" ,
                   title: "Fast shipping",
                   description: "Get all of your desired sneakers in one place"
                  ),
    OnboardingItem(image1: "purplesneaker",
                   image2: "whitesneaker" ,
                   title: "Fast shipping",
                   description: "Get all of your desired sneakers in one place"
        
    ),
    OnboardingItem(image1: "whitegreen",
                   image2: "orangepair" ,
                   title: "Fast shipping",
                   description: "Get all of your desired sneakers in one place"
                  )
]

