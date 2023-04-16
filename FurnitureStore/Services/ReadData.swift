//
//  ReadData.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 16.04.2023.
//

import SwiftUI


class ReadData: ObservableObject  {
    
    @Published var furniture : Furniture?
  
    
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
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
