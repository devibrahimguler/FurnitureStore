//
//  MainView.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var appModel : AppViewModel = .init()
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $appModel.currentTab) {
            Home(animation: animation)
                .environmentObject(appModel)
                .tag(Tab.home)
                .setUpTab()
            
            Text("Cart")
                .tag(Tab.cart)
                .setUpTab()
            
            Text("Favourite")
                .tag(Tab.favourite)
                .setUpTab()
            
            Text("Profile")
                .tag(Tab.profile)
                .setUpTab()
            
        }
        .overlay(alignment: .bottom) {
            CustomTabBar(currentTab: $appModel.currentTab, animation: animation)
                .offset(y: appModel.showDetailView ? 150 : 0)
        }
        .overlay {
            if let products = appModel.currentActiveItem, appModel.showDetailView {
                DetailView(products: products, animation: animation)
                    .environmentObject(appModel)
                    .transition(.offset(x:1, y:1))
            }
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
