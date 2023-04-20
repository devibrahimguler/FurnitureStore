//
//  MainView.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var homeViewModel : HomeViewModel = .init()
    @StateObject var cartViewModel : CartViewModel = .init()
    @State var currentTab: Tab = .favourite
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            
            Home(animation: animation)
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .tag(Tab.home)
                .setUpTab()
            
            Cart()
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .tag(Tab.cart)
                .setUpTab()
            
            Favourite(animation: animation)
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .tag(Tab.favourite)
                .setUpTab()
            
            Text("Profile")
                .tag(Tab.profile)
                .setUpTab()
            
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $currentTab, animation: animation)
                .offset(y: homeViewModel.showDetailView ? 150 : 0)
        }
        .overlay {
            if let products = homeViewModel.currentActiveItem, homeViewModel.showDetailView {
                DetailView(products: products, animation: animation)
                    .environmentObject(homeViewModel)
                    .environmentObject(cartViewModel)
                    .transition(.offset(x:1, y:1))
            }
        }
        .alert(isPresented: $cartViewModel.showAlert) {
            Alert(title: Text("Add"), message: Text("Added in Cart"), dismissButton: .cancel(Text("Okey")))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension View {
    @ViewBuilder
    func setUpTab() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color("BG")
                    .ignoresSafeArea()
            }
    }
}

enum Tab: String, CaseIterable {
    case home = "Home"
    case cart = "Cart"
    case favourite = "Star"
    case profile = "Profile"
}
