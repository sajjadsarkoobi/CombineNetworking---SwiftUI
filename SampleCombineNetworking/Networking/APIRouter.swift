//
//  APIRouter.swift
//  HICH
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import Foundation

class APIRouter {
    
    // GET Request
    struct GetProducts: Request {
        typealias ReturnType = ProductsModel
        var path: String = "/products"
        var method: HTTPMethod = .get
        var queryParams: [String : Any]?
        init(queryParams: APIParameters.ProductParams) {
            self.queryParams = queryParams.asDictionary
        }
    }
    
    struct AddProduct: Request {
        typealias ReturnType = AddedProductModel
        var path: String = "/products/add"
        var method: HTTPMethod = .post
        var body: [String : Any]?
        init(body: APIParameters.AddProductParams) {
            self.body = body.asDictionary
        }
    }
}
