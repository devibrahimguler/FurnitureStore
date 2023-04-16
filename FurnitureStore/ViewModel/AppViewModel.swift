//
//  AppViewModel.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var furniture: Furniture = ReadData().furniture!
    @Published var products: [Products] = []
    @Published var searchProducts: [Products] = []
    @Published var currentActiveItem : Products?
    
    @Published var currentTab: Tab = .home
    @Published var currentMenu : SliderMenu = .all
    
    @Published var searchText: String = ""
    
    @Published var showDetailView : Bool = false
    @Published var showDetailContent : Bool = false
    @Published var cartCount : Int = 0
    
    init() {
        updateMenu(newValue: .all)
    }
    
    func searchFromProducts() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchProducts = results.compactMap { product in
                    return product
                }
                
            }
            
        }
    }
    
    func updateMenu(newValue: SliderMenu) {
        withAnimation(.easeInOut(duration: 0.5)) {
            if(furniture.search_parameters.q == newValue.rawValue.lowercased() || currentMenu == .all) {
                self.products = furniture.products
            } else {
                self.products = []
            }
        }
        
    }
    
    func sortByPrice(isAscending: Bool) {
        self.products.sort {
            if isAscending {
                return $0.price < $1.price
            } else {
                return $0.price > $1.price
            }
            
        }
        
    }
}

enum SliderMenu: String, CaseIterable {
    case all = "All"
    case chair = "Chair"
    case table = "Table"
    case lamp = "Lamp"
    case floor = "Floor"
}

enum Tab: String, CaseIterable {
    case home = "Home"
    case cart = "Cart"
    case favourite = "Star"
    case profile = "Profile"
}
