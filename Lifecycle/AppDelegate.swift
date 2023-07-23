//
//  AppDelegate.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import UIKit
import AIArtKit
import Foundation
import PurchaseKit
import GoogleMobileAds
import AppTrackingTransparency

/// App Delegate file in SwiftUI
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PKManager.loadProducts(identifiers: [AppConfig.premiumVersion])
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in self.requestIDFA() }
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            AIArtConfigurator.configure(purchaseCode: "CodeCanyon_Item_Purchase_Code", rootController: rootController)
        }
        return true
    }
    
    /// Display the App Tracking Transparency authorization request for accessing the IDFA
    func requestIDFA() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }
    }
}

// MARK: - Google AdMob Interstitial - Support class
class Interstitial: NSObject, GADFullScreenContentDelegate {
    var isPremiumUser: Bool = UserDefaults.standard.bool(forKey: AppConfig.premiumVersion)
    private var interstitial: GADInterstitialAd?
    static var shared: Interstitial = Interstitial()

    /// Default initializer of interstitial class
    override init() {
        super.init()
        loadInterstitial()
    }

    /// Request AdMob Interstitial ads
    func loadInterstitial() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: AppConfig.adMobAdId, request: request, completionHandler: { [self] ad, error in
            if ad != nil { interstitial = ad }
            interstitial?.fullScreenContentDelegate = self
        })
    }

    func showInterstitialAds() {
        if self.interstitial != nil, !isPremiumUser {
            guard let root = rootController else { return }
            self.interstitial?.present(fromRootViewController: root)
        }
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        loadInterstitial()
    }
}
