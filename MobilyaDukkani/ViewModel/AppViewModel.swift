//
//  AppViewModel.swift
//  MobilyaDukkani
//
//  Created by İbrahim Güler on 30.05.2022.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var currentTab: Tab = .home
    @Published var currentMenu : String = "All"
    @Published var showDetailView : Bool = false
    @Published var currentActiveItem : Furniture?
}
