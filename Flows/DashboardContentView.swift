//
//  DashboardContentView.swift
//  ArtGenerator
//
//  Created by Apps4World on 12/15/22.
//

import SwiftUI

/// The main dashboard for the app with the header view and tab bar
struct DashboardContentView: View {
    
    @EnvironmentObject var manager: DataManager
    @State private var selectedTab: CustomTabBarItem = .home
    
    // MARK: - Main rendering function
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            CustomTabBarContainer
            CustomTabBarView
        }
    }
    
    /// Custom tab bar container
    private var CustomTabBarContainer: some View {
        VStack(spacing: 15) {
            HeaderTitle
            switch selectedTab {
            case .home:
                HomeTabView()
            case .creator:
                CreatorTabView()
            case .settings:
                SettingsTabView()
            }
        }.environmentObject(manager)
    }
    
    /// Header title
    private var HeaderTitle: some View {
        let components = selectedTab.headerTitle.components(separatedBy: " ")
        return ZStack {
            if components.count > 1 {
                Text(components.joined(separator: " ").replacingOccurrences(of: components.last!, with: "")).bold() + Text(components.last!)
            } else {
                Text(components.joined()).bold()
            }
        }.font(.system(size: 27)).foregroundColor(.white)
    }
    
    /// Bottom Custom tab bar view
    private var CustomTabBarView: some View {
        ZStack {
            VStack {
                Spacer()
                Color.black.frame(height: 110)
            }.ignoresSafeArea()
            VStack {
                Spacer()
                HStack(spacing: 65) {
                    ForEach(CustomTabBarItem.allCases) { tabItem in
                        TabBarItem(type: tabItem)
                    }
                }
            }
        }
    }
    
    private func TabBarItem(type: CustomTabBarItem) -> some View {
        let iconSize: Double = type == .creator ? 40 : 25
        return VStack {
            Spacer()
            Image(systemName: type.rawValue).resizable().aspectRatio(contentMode: .fit)
                .frame(width: iconSize, height: iconSize)
                .opacity(selectedTab == type ? 1 : 0.4).onTapGesture {
                    selectedTab = type
                }
            Text("\(type)".capitalized).font(.system(size: 14)).opacity(0.4)
        }.foregroundColor(.white)
    }
}

// MARK: - Preview UI
struct DashboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardContentView().environmentObject(DataManager())
    }
}
