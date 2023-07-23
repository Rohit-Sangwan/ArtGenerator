//
//  AppConfig.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI
import Foundation

/// Generic configurations for the app
class AppConfig {
    
    /// This is the AdMob Interstitial ad id
    /// Test App ID: ca-app-pub-3940256099942544~1458002511
    static let adMobAdId: String = "ca-app-pub-3940256099942544/4411468910"
    
    // MARK: - Settings flow items
    static let emailSupport = "support@apps4world.com"
    static let privacyURL: URL = URL(string: "https://www.google.com/")!
    static let termsAndConditionsURL: URL = URL(string: "https://www.google.com/")!
    static let yourAppURL: URL = URL(string: "https://apps.apple.com/app/idXXXXXXXXX")!
    
    // MARK: - In App Purchases
    static let premiumVersion: String = "ArtGenerator.Premium"
    static let freeImageGenerationCount: Int = 1
    
    // MARK: - Open AI Configurations
    static let apiKey: String = "sk-xxxxxxxxxxxx" /// <- replace with your own key
    
    // MARK: - Get Inspired assets
    static let inspirationAssets: [AssetModel] = [
        .init(imageName: "princess-one", imageText: "Macro closeup headshot of a beautiful happy magical fairy princess wearing a white robe and flowers in her hair in a fantasy garden, d & d, fantasy, intricate, rim light, god rays, volumetric lighting, elegant, highly detailed, digital painting, artstation, concept art, smooth, sharp focus, illustration, art by greg rutkowski, maxfield parrish and alphonse mucha, sunrise, new art nouveau, soft ambient lighting, particle effects", isHorizontal: true, category: ""),
        .init(imageName: "princess-two", imageText: "Ultra realistic photo, princess peach in the mushroom kingdom, beautiful face, intricate, highly detailed, smooth, sharp focus, art by artgerm and greg rutkowski and alphonse mucha", isHorizontal: true, category: ""),
        .init(imageName: "another-world", imageText: "another world, tropical style,extreme detail, bestview,view from planet, landscape extreme detail, high detail graphics, hyper detailed,cinematic, 8k, vivid, vibrant colors, lighting shaders cinematic style, cloud, land, snow, winter dawn on background, Beautiful Lighting, Dynamic Lighting", isHorizontal: true, category: ""),
        .init(imageName: "pyramids", imageText: "pyramid of giza abstract", isHorizontal: true, category: ""),
        
        .init(imageName: "santa", imageText: "Santa eats christmas cookies and milk", isHorizontal: false, category: "Characters"),
        .init(imageName: "cat", imageText: "kneeling cat knight, portrait, finely detailed armor, intricate design, silver, silk, cinematic lighting, 4k", isHorizontal: false, category: "Characters"),
        .init(imageName: "dead", imageText: "day of the dead portrait of disney zelda, intricate, elegant, highly detailed, my rendition, digital painting, artstation, concept art, smooth, sharp focus, illustration, art by artgerm and greg rutkowski and alphonse mucha and uang guangjian and gil elvgren and sachin teng, symmetry!!", isHorizontal: false, category: "Characters"),
        .init(imageName: "superheroes", imageText: "All superheroes in the New York City", isHorizontal: false, category: "Characters"),

        .init(imageName: "coral", imageText: "Coral reef phoenix at night with a sky full of stars, intricate, elegant, highly detailed digital painting, artstation, concept art, sharp focus, octane render, illustration, volumetric lighting, epic Composition, 8k, art by Akihiko Yoshida and Greg Rutkowski and Craig Mullins, oil painting, cgsociety", isHorizontal: false, category: "Landscapes"),
        .init(imageName: "turtle", imageText: "Giant turtle with a village built in to it’s shell, lots of fishing boats visible in the distance, waterfalls from the river, concept art, low angle, high detail, warm lighting, volumetric, godrays, vivid, beautiful, trending on artstation, by Jordan grimmer, huge scene", isHorizontal: false, category: "Landscapes"),
        .init(imageName: "ancient", imageText: "Half buried ruins of an ancient lost civilization at sunset, shadows, epic composition, intricate, elegant, volumetric lighting, digital painting, highly detailed, artstation, sharp focus", isHorizontal: false, category: "Landscapes"),
        .init(imageName: "forest", imageText: "enchanted forest, with a path between the trees, sun shining, close up, Cinematic Lighting, High res and ultra realistic, hyper detailed, 8k, area of rocks, deep inside the forest, divine domain", isHorizontal: false, category: "Landscapes"),
        .init(imageName: "sunset", imageText: "Sunset in the mountains", isHorizontal: false, category: "Landscapes"),

        .init(imageName: "puppy", imageText: "Puppy in glasses reading a book", isHorizontal: false, category: "Animals"),
        .init(imageName: "dragon", imageText: "Dragon flying over the castle", isHorizontal: false, category: "Animals"),
        .init(imageName: "kitten", imageText: "A cute Ragdoll cat kitten riding a kayak down violent rapids, holding a paddle and struggling to survive, action scene, low angle, detailed, high detail, dynamic lighting, warm lighting, volumetric, godrays, vivid, beautiful, huge scene, trending on artstation, by jordan grimmer, art greg rutkowski", isHorizontal: false, category: "Animals"),
        .init(imageName: "Raccoon", imageText: "Raccoon winter wonderland", isHorizontal: false, category: "Animals")
    ]
}

// MARK: - Custom tab bar items
enum CustomTabBarItem: String, Identifiable, CaseIterable {
    case home = "house.fill", creator = "plus.circle.fill", settings = "gearshape.fill"
    var id: Int { hashValue }
    
    /// Custom header title for each tab
    var headerTitle: String {
        switch self {
        case .home: return "Get Inspired"
        case .creator: return "AI Art Generator"
        case .settings: return "Settings"
        }
    }
}

/// Main app colors
extension Color {
    static let textInputColor: Color = Color("TextInputColor")
}
