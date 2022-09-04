//
//  ProductsModel.swift
//  SampleCombineNetworking
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import Foundation

// MARK: - Products
struct ProductsModel: Codable {
    let products: [ProductModel]
    let total: Int
    let skip: String
    let limit: Int
}

// MARK: - Product
struct ProductModel: Codable, Hashable {
    let id: Int
    let title, productDescription: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}


//Model for adding product
struct AddedProductModel: Codable {
    let id: Int
}
