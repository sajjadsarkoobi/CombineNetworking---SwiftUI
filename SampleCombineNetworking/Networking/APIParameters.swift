//
//  APIParameters.swift
//  HICH
//
//  Created by Sajjad Sarkoobi on 3.09.2022.
//

import Foundation

protocol DictionaryConvertor: Codable {}


//MARK: APIParameters for using in URLrequests
/// Structs that containg all parameters that needed for passing data as body or queary strings to urlrequest
/// it is conforimig to DictionaryConvertor
struct APIParameters {
    struct ProductParams: DictionaryConvertor {
        var skip: Int?
        var limit: Int?
    }
    
    struct AddProductParams: DictionaryConvertor {
        var title: String?
    }
}


//MARK: - Convert Struct to Dictionary for using in body or queryStrings
extension DictionaryConvertor {
    /// implement convert Struct or Class to Dictionary
    func convertToDict() -> Dictionary<String, Any>? {

        var dict: Dictionary<String, Any>? = nil

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>

        } catch {
            Log.error(error.localizedDescription)
        }
        return dict
    }
}
