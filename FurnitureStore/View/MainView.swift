//
//  MainView.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var homeViewModel : HomeViewModel
    @EnvironmentObject var cartViewModel : CartViewModel
    @EnvironmentObject var profileViewModel : ProfileViewModel
    @Binding var currentTab: Tab
    var animation : Namespace.ID
    
    
    init(currentTab: Binding<Tab>, animation: Namespace.ID) {
        UITabBar.appearance().isHidden = true
        
        self._currentTab = currentTab
        self.animation = animation
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            
            Home(animation: animation)
                .environmentObject(homeViewModel)
                .environmentObject(cartViewModel)
                .environmentObject(profileViewModel)
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
            
            Profile(currentTab: $currentTab)
                .environmentObject(profileViewModel)
                .tag(Tab.profile)
                .setUpTab()
            
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $currentTab, animation: animation, isUserTab: profileViewModel.isLogged)
                .offset(y: homeViewModel.showDetailView ? 150 : 0)
        }
        .overlay {
            if let products = homeViewModel.currentActiveItem, homeViewModel.showDetailView {
                DetailView(products: products, animation: animation)
                    .environmentObject(homeViewModel)
                    .environmentObject(cartViewModel)
                    .transition(.offset(x:1, y:1))
            }
             
            Login()
                .environmentObject(homeViewModel)
                .environmentObject(profileViewModel)
                .offset(.init(width: 0, height: profileViewModel.offsetLogin))
                .animation(.easeInOut(duration: 1), value: profileViewModel.offsetLogin)
        }
        .alert(isPresented: $cartViewModel.showAlert) {
            Alert(title: Text("Add"), message: Text("Added in Cart"), dismissButton: .cancel(Text("Okey")))
        }
        .alert(isPresented: $profileViewModel.showAlert) {
            Alert(title: Text("Error"), message: Text(profileViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
