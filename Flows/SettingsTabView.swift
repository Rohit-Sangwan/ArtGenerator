//
//  SettingsTabView.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI
import StoreKit
import MessageUI
import PurchaseKit

/// Shows the main settings for the app
struct SettingsTabView: View {
    
    @EnvironmentObject var manager: DataManager
    @State private var remindersTime: Date = Date()
    @State private var didConfigureTime: Bool = false
    
    // MARK: - Main rendering function
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center, spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer(minLength: 5)
                    VStack {
                        if manager.isPremiumUser == false {
                            InAppPurchasesPromoBannerView
                            CustomHeader(title: "In-App Purchases")
                            InAppPurchasesView
                        }
                        CustomHeader(title: "Spread the Word")
                        RatingShareView
                        CustomHeader(title: "Support & Privacy")
                        PrivacySupportView
                    }.padding(.horizontal, 20)
                    Spacer(minLength: 100)
                }
            }
            LoadingView(isLoading: $manager.showLoadingView)
        }
    }
    
    /// Create custom header view
    private func CustomHeader(title: String) -> some View {
        HStack {
            Text(title).font(.system(size: 18, weight: .medium))
            Spacer()
        }.foregroundColor(.white)
    }
    
    /// Custom settings item
    private func SettingsItem(title: String, icon: String, action: @escaping() -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Image(systemName: icon).resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22, alignment: .center)
                Text(title).font(.system(size: 18))
                Spacer()
                Image(systemName: "chevron.right")
            }.foregroundColor(.white).padding()
        })
    }
    
    // MARK: - In App Purchases
    private var InAppPurchasesView: some View {
        VStack {
            SettingsItem(title: "Upgrade Premium", icon: "crown") {
                manager.showLoadingView = true
                PKManager.purchaseProduct(identifier: AppConfig.premiumVersion) { _, status, _ in
                    DispatchQueue.main.async {
                        self.manager.showLoadingView = false
                        if status == .success {
                            self.manager.isPremiumUser = true
                        }
                    }
                }
            }
            Color.white.frame(height: 1).opacity(0.1)
            SettingsItem(title: "Restore Purchases", icon: "arrow.clockwise") {
                manager.showLoadingView = true
                PKManager.restorePurchases { _, status, _ in
                    DispatchQueue.main.async {
                        self.manager.showLoadingView = false
                        if status == .restored {
                            self.manager.isPremiumUser = true
                        }
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    DispatchQueue.main.async {
                        self.manager.showLoadingView = false
                    }
                }
            }
        }.padding([.top, .bottom], 5).background(
            Color.white.cornerRadius(15).opacity(0.1)
                .shadow(color: Color.black.opacity(0.07), radius: 10)
        ).padding(.bottom, 40)
    }
    
    private var InAppPurchasesPromoBannerView: some View {
        ZStack {
            Color.textInputColor
            HStack {
                VStack(alignment: .leading) {
                    Text("Premium Version").bold().font(.system(size: 20))
                    Text("- Unlimited Art").font(.system(size: 15)).opacity(0.7)
                    Text("- Remove Ads").font(.system(size: 15)).opacity(0.7)
                }
                Spacer()
                Image(systemName: "crown.fill").font(.system(size: 45))
            }.foregroundColor(.white).padding([.leading, .trailing], 20)
        }.frame(height: 110).cornerRadius(16).padding(.bottom, 5)
    }
 
    // MARK: - Rating and Share
    private var RatingShareView: some View {
        VStack {
            SettingsItem(title: "Rate App", icon: "star") {
                if let scene = UIApplication.shared.windows.first?.windowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
            Color.white.frame(height: 1).opacity(0.1)
            SettingsItem(title: "Share App", icon: "square.and.arrow.up") {
                let shareController = UIActivityViewController(activityItems: [AppConfig.yourAppURL], applicationActivities: nil)
                rootController?.present(shareController, animated: true, completion: nil)
            }
        }.padding([.top, .bottom], 5).background(
            Color.white.cornerRadius(15).opacity(0.1)
                .shadow(color: Color.black.opacity(0.07), radius: 10)
        ).padding(.bottom, 40)
    }
    
    // MARK: - Support & Privacy
    private var PrivacySupportView: some View {
        VStack {
            SettingsItem(title: "E-Mail us", icon: "envelope.badge") {
                EmailPresenter.shared.present()
            }
            Color.white.frame(height: 1).opacity(0.1)
            SettingsItem(title: "Privacy Policy", icon: "hand.raised") {
                UIApplication.shared.open(AppConfig.privacyURL, options: [:], completionHandler: nil)
            }
            Color.white.frame(height: 1).opacity(0.1)
            SettingsItem(title: "Terms of Use", icon: "doc.text") {
                UIApplication.shared.open(AppConfig.termsAndConditionsURL, options: [:], completionHandler: nil)
            }
        }.padding([.top, .bottom], 5).background(
            Color.white.cornerRadius(15).opacity(0.1)
                .shadow(color: Color.black.opacity(0.07), radius: 10)
        )
    }
}

// MARK: - Preview UI
struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView().environmentObject(DataManager())
    }
}

// MARK: - Mail presenter for SwiftUI
class EmailPresenter: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailPresenter()
    private override init() { }
    
    func present() {
        if !MFMailComposeViewController.canSendMail() {
            presentAlert(title: "Email Client", message: "Your device must have the native iOS email app installed for this feature.")
            return
        }
        let picker = MFMailComposeViewController()
        picker.setToRecipients([AppConfig.emailSupport])
        picker.mailComposeDelegate = self
        rootController?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        rootController?.dismiss(animated: true, completion: nil)
    }
}
