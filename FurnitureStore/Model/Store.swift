//
//  Store.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 17.04.2023.
//

import SwiftUI

struct Store : Identifiable {
    var id : UUID = UUID()
    var products: Products
    var count: Int
}
