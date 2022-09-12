//
//  ProductViewModel.swift
//  SampleCombineNetworking
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published var products: [ProductModel] = []
    @Published var productAdded: Bool = false
    var cancelable: Set<AnyCancellable> = []
    
    //GET Method
    func getProducts() {
        APIClient.dispatch(
            APIRouter.GetProducts(queryParams:
                                    APIParameters.ProductParams(skip: 1, limit: 10)))
        .sink { _ in }
        receiveValue: { [weak self] products in
            self?.products = products.products
        }.store(in: &cancelable)
    }
    
    //Post Method
    func addProduct(productName: String) {
        if productName.isEmpty { return }
        APIClient.dispatch(
            APIRouter.AddProduct(body:
                                    APIParameters.AddProductParams(title: productName)))
        .sink { _ in
        } receiveValue: { [weak self] product in
            Log.info("Added product-> \(product.id)")
            self?.productAdded.toggle()
        }.store(in: &cancelable)
    }
}
