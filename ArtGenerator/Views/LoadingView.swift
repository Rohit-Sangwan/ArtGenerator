//
//  LoadingView.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI

/// Show a loading indicator view
struct LoadingView: View {
    
    @Binding var isLoading: Bool
    
    // MARK: - Main rendering function
    var body: some View {
        ZStack {
            if isLoading {
                Color.black.edgesIgnoringSafeArea(.all).opacity(0.6)
                ProgressView("please wait...")
                    .scaleEffect(1.1, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white).padding()
                    .background(RoundedRectangle(cornerRadius: 10).opacity(0.8))
                    .offset(y: 50)
            }
        }.colorScheme(.light)
    }
}
