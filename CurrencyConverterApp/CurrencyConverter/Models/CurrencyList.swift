//
//  CurrencyList.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation


class CurrencyList: Codable {
    let currencies : [String: String]

    required init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        currencies = try decoder.decode([String: String].self, forKey: .currencies)
    }
    
}

