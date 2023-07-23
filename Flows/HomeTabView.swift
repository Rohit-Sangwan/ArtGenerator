//
//  HomeTabView.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI

/// Home tab with a list of ideas
struct HomeTabView: View {
    
    @EnvironmentObject var manager: DataManager
    
    // MARK: - Main rendering function
    var body: some View {
        let categories: [String] = Array(Set(AppConfig.inspirationAssets.map({ $0.category }))).sorted(by: >).filter { !$0.isEmpty }
        return ScrollView(.vertical) {
            VStack(spacing: 40) {
                HorizontalCarouselView
                VStack(spacing: 35) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        AssetsList(forCategory: categories[index])
                    }
                }
            }
            Spacer(minLength: 100)
        }
    }
    
    /// Assets carousel
    private func Carousel(assets: [AssetModel], size: CGFloat) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                Spacer(minLength: 5)
                ForEach(0..<assets.count, id: \.self) { index in
                    Rectangle().foregroundColor(.white.opacity(0.2))
                        .frame(width: size, height: size)
                        .overlay(
                            ZStack {
                                if let image = UIImage(named: assets[index].imageName) {
                                    Image(uiImage: image)
                                        .resizable().aspectRatio(contentMode: .fill)
                                }
                            }
                        ).cornerRadius(15).onTapGesture {
                            presentAlert(title: "Image Description", message: assets[index].imageText, primaryAction: .init(title: "Copy Text", style: .default, handler: { _ in
                                UIPasteboard.general.string = assets[index].imageText
                                Interstitial.shared.showInterstitialAds()
                            }))
                        }
                }
                Spacer(minLength: 5)
            }
        }
    }
    
    /// Horizontal carousel
    private var HorizontalCarouselView: some View {
        let assets: [AssetModel] = AppConfig.inspirationAssets.filter { $0.isHorizontal }
        let size: CGFloat = UIScreen.main.bounds.width/1.5
        return Carousel(assets: assets, size: size)
    }
    
    /// Vertical categories list
    private func AssetsList(forCategory category: String) -> some View {
        let assets: [AssetModel] = AppConfig.inspirationAssets.filter { $0.category == category }
        let size: CGFloat = UIScreen.main.bounds.width/3.0
        return VStack {
            HStack {
                Text(category).foregroundColor(.white).bold()
                Spacer()
            }.padding(.horizontal, 20)
            Carousel(assets: assets, size: size)
        }
    }
}

// MARK: - Preview UI
struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView().environmentObject(DataManager())
    }
}
