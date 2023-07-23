//
//  CreatorTabView.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI
import AIArtKit

/// Main AI Art creator
struct CreatorTabView: View {
    
    @EnvironmentObject var manager: DataManager
    
    // MARK: - Main rendering function
    var body: some View {
        let imageSize: CGFloat = UIScreen.main.bounds.width - 80
        return ZStack {
            Color.black.ignoresSafeArea()
            ZStack {
                if let generatedImage = manager.generatedImage {
                    Image(uiImage: generatedImage).resizable().aspectRatio(contentMode: .fit)
                        .frame(width: imageSize, height: imageSize).cornerRadius(20)
                        .overlay(SaveImageButton)
                } else {
                    AnimatedLogoSection
                }
            }.padding(.bottom, UIScreen.main.bounds.height/3)
            VStack(spacing: 30) {
                Spacer()
                PromptInputField
                GeneratePhotoButton
            }.padding(.bottom, 100)
            LoadingView(isLoading: $manager.showLoadingView)
        }
    }
    
    /// Animated logo section
    private var AnimatedLogoSection: some View {
        let size: CGFloat = UIScreen.main.bounds.width
        return AnimatedLogoView().frame(width: size, height: size)
    }
    
    /// AI Text Prompt input
    private var PromptInputField: some View {
        TextField("Describe your photo idea...", text: $manager.promptText)
            .preferredColorScheme(.dark).accentColor(.white)
            .padding().padding(.horizontal, 8).background(
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.textInputColor)
                    .opacity(0.7)
            ).padding(.horizontal, 30)
    }
    
    /// Generate photo button
    private var GeneratePhotoButton: some View {
        Button {
            hideKeyboard()
            Task { await manager.generateArt() }
        } label: {
            Text("Generate Art")
                .foregroundColor(.white)
                .foregroundLinearGradient(
                    colors: [.pink, .purple, .blue, .blue.opacity(0.3)],
                    startPoint: .leading, endPoint: .trailing
                ).font(Font.system(size: 26, weight: .bold))
        }
    }
    
    /// Save image button overlay
    private var SaveImageButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button { manager.saveGeneratedArt() } label: {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundColor(.black.opacity(0.8)).padding(10)
                        .background(Circle().foregroundColor(.white).shadow(radius: 10))
                }
            }.padding(10)
        }
    }
}

// MARK: - Preview UI
struct CreatorTabView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorTabView().environmentObject(DataManager())
    }
}
