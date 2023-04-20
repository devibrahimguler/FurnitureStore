//
//  AppViewModel.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var furniture: Furniture?
    
    @Published var favourite: [Products] = []

    @Published var products: [Products] = []
    @Published var searchProducts: [Products] = []
    @Published var currentActiveItem : Products?
    
    @Published var currentMenu : SliderMenu = .chair
    
    @Published var searchText: String = ""
    
    @Published var showDetailView : Bool = false
    @Published var showDetailContent : Bool = false
    
    init() {
        updateMenu(newValue: .chair)
    }
    
    func getDataFurniture() {
        self.furniture = ReadData(selection: currentMenu).furniture
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
        getDataFurniture()
        withAnimation(.easeInOut(duration: 0.5)) {
            if(furniture!.search_parameters.q == newValue.rawValue.lowercased()) {
                self.products = furniture!.products
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
    case chair = "Chair"
    case table = "Table"
    case lamp = "Lamp"
    case floor = "Floor"
}


