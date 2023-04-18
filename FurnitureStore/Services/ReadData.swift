//
//  ReadData.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 16.04.2023.
//

import SwiftUI


class ReadData: ObservableObject  {
    
    @Published var furniture : Furniture?
    var selection : SliderMenu
    
    init(selection : SliderMenu){
        self.selection = selection
        self.loadData(selection: self.selection)
    }
    
    func loadData(selection: SliderMenu)  {
        var data = "data"
        switch(selection) {
        case .chair:
            data = "data"
        case .table:
            data = "table"
        case .lamp:
            data = "lamp"
        case .floor:
            data = "floor"
        }
        
        guard let url = Bundle.main.url(forResource: data, withExtension: "json") else {
            print("Json file not found")
            return
        }
        
        do{
            let data = try Data(contentsOf: url)
            let furniture = try JSONDecoder().decode(Furniture.self, from: data)
            self.furniture = furniture
        }
        catch  {
            print("hata var === \(error)")
        }
        
    }

    
    
    

    
}
