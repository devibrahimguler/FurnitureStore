//
//  ImageDownloaderClient.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 16.04.2023.
//

import SwiftUI

final class ImageDownloaderClient : ObservableObject {
    
    @Published var downloadedImage : Image?
    
    private let cache = NSCache<NSString, UIImage>()
    
    func downloadingImage(products: Products) {
        guard let imageUrl = URL(string: products.thumbnails[0].last ?? "") else { return }
        if let image = self.cache.object(forKey: products.product_id as NSString) {
            DispatchQueue.main.async {
                self.downloadedImage = Image(uiImage: image)
                return
            }
        }
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data , error == nil else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.downloadedImage = nil
                    return
                }
                self.cache.setObject(image, forKey: products.product_id as NSString)
                self.downloadedImage = Image(uiImage: image)
            }
        }
        
        task.resume()
    }
    
}

