//
//  StoreViewModel.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 17.04.2023.
//

import SwiftUI

class CartViewModel: ObservableObject {

    @Published var store : [Store] = []
    
    @Published var showAlert : Bool = false
    @Published var cartCount : Int = 0
    
    @Published var subTotalPrice : Double = 0
    @Published var totalPrice : Double = 0
    @Published var tax : Double = 0
    
    func appendStore(products: Products, count: Int) {
        if count != 0 {
            DispatchQueue.main.async {
                if let index =  self.store.firstIndex(where: {$0.products.id == products.id}) {
                    self.store[index].count += count
                    self.priceTotaling(products: products, count: count)
                    return
                }
                self.priceTotaling(products: products, count: count)
                self.store.append(Store(products: products, count: count))
            }
        }
    }
    
    private func priceTotaling(products: Products, count: Int) {
        self.subTotalPrice += (products.price * Double(count))
        self.tax += ((products.price * Double(count) * 8.00) / 100.00)
        self.totalPrice = (self.subTotalPrice + self.tax + 100.00)
    }
    
}
