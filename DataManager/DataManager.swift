//
//  DataManager.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import UIKit
import SwiftUI
import AIArtKit
import Foundation

/// Main data manager for the app
class DataManager: AIArtManager, ObservableObject {
    
    /// Dynamic properties that the UI will react to
    @Published var promptText: String = ""
    @Published var generatedImage: UIImage?
    @Published var showLoadingView: Bool = false
    
    /// Dynamic properties that the UI will react to AND store values in UserDefaults
    @AppStorage(AppConfig.premiumVersion) var isPremiumUser: Bool = false {
        didSet { Interstitial.shared.isPremiumUser = isPremiumUser }
    }
    
    /// Check if the user can generate more Art based on their in-app purchases status
    override var canGenerateMoreArt: Bool {
        isPremiumUser || generatedArtCount < AppConfig.freeImageGenerationCount
    }
    
    override func presentGenericErrorAlert() {
        presentAlert(title: "Oops!", message: "Something went wrong. Please try again later.", primaryAction: .init(title: "OK", style: .default, handler: { _ in
            DispatchQueue.main.async {
                self.generatedImage = nil
                self.showLoadingView = false
                self.promptText = ""
            }
        }))
    }
    
    override func presentLimitErrorAlert() {
        presentAlert(title: "Limit Reached", message: "You can generate only \(AppConfig.freeImageGenerationCount) photos for free. Select the Settings tab below to upgrade to the premium version.")
    }
}

// MARK: - Generate AI Art
extension DataManager {
    
    /// Generate AI Art based on the prompt text
    func generateArt() async {
        DispatchQueue.main.async {
            self.generatedImage = nil
            self.showLoadingView = true
        }
        generatedImage = await generateImage(promptText: promptText, apiKey: AppConfig.apiKey)
        DispatchQueue.main.async { self.showLoadingView = false }
    }
    
    /// Generated Art count
    private var generatedArtCount: Int {
        UserDefaults.standard.integer(forKey: "generatedArtCount")
    }
}

// MARK: - Save generated AI Art
extension DataManager {
    
    /// Save generated AI image to photos
    func saveGeneratedArt() {
        guard let image = generatedImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    /// Save image confirmation/error alert
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        var message = "Your AI Art has been saved!"
        if let errorMessage = error?.localizedDescription { message = errorMessage }
        let alert = UIAlertController(title: error != nil ? "Error" : "Saved!", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: { _ in
            Interstitial.shared.loadInterstitial()
        }))
        rootController?.present(alert, animated: true, completion: nil)
    }
}
