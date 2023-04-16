//
//  Products.swift
//  FurnitureStore
//
//  Created by İbrahim Güler on 16.04.2023.
//

import SwiftUI

struct Furniture : Codable, Identifiable {
    private enum CodingKeys: CodingKey {
        case search_metadata
        case search_parameters
        case search_information
        case products
    }
    
    var id = UUID()
    var search_metadata: SearchMetadata
    var search_parameters: SearchParameters
    var search_information: SearchInformation
    var products: [Products]
}

struct SearchMetadata : Codable {
    private enum CodingKeys: CodingKey {
        case id
        case status
        case json_endpoint
        case created_at
        case processed_at
        case home_depot_url
        case raw_html_file
        case prettify_html_file
        case total_time_taken

    }
    var id: String
    var status: String
    var json_endpoint: String
    var created_at: String
    var processed_at: String
    var home_depot_url: String
    var raw_html_file: String
    var prettify_html_file: String
    var total_time_taken: Double
}

struct SearchParameters : Codable {
    private enum CodingKeys: CodingKey {
        case q
        case nao
        case ps
        case delivery_zip
        case store_id
        case engine
    }
    var q: String
    var nao: String
    var ps: Int
    var delivery_zip: String
    var store_id: String
    var engine: String
}

struct SearchInformation : Codable {
    private enum CodingKeys: CodingKey {
        case results_state
        case total_results
    }
    var results_state: String
    var total_results: Int
}

struct Products : Codable, Identifiable {
    private enum CodingKeys: CodingKey {
        case position
        case product_id
        case title
        case thumbnails
        case link
        case serpapi_link
        case model_number
        case collection
        case rating
        case price
    }
    
    var id = UUID()
    var position: Int
    var product_id: String
    var title: String
    var thumbnails: [[String]]
    var link: String
    var serpapi_link: String
    var model_number: String
    var collection: String
    var rating: Double
    var price: Double
}
