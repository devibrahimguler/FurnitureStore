//
//  ContentView.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 29.05.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel : HomeViewModel = .init()
    @StateObject var cartViewModel : CartViewModel = .init()
    @StateObject var profileViewModel : ProfileViewModel = .init()
    @State var currentTab: Tab = .home
    @Namespace var animation
    var body: some View {
        if(profileViewModel.isLoading) {
            IntroView()
        } else {
            MainView(currentTab: $currentTab, animation: animation)
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(profileViewModel)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
