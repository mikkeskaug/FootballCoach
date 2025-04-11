//
//  MainTabView.swift
//  FootballCoach
//
//  Created by Jon Mikael Skaug on 10/4/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            TrainingView()
                .tabItem {
                    Label("Training", systemImage: "field.of.view.wide")
                }
            MatchView()
                .tabItem {
                    Label("Match", systemImage: "soccerball.inverse")
                }
        } //End of TabView
    }
}

#Preview {
    MainTabView()
}
