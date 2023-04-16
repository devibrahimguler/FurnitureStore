//
//  Images.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 16.04.2023.
//

import SwiftUI

struct Images: View {
    
    @StateObject var imageDownloaderClient : ImageDownloaderClient = ImageDownloaderClient()
    var products : Products
  
    init(products: Products) {

        self.products = products
    }
   
    var body: some View{
        VStack(spacing: 0) {
            if let image = self.imageDownloaderClient.downloadedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }else {
                ProgressView()
            }
        }.onAppear {
            DispatchQueue.main.async {
                imageDownloaderClient.downloadingImage(products: products)
            }
        }
    }
}
