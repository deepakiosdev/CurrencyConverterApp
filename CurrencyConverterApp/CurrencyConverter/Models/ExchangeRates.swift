//
//  ExchangeRates.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation


class ExchangeRates: Codable {
    
    let rateList : [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case rateList = "quotes"
    }
    
    required init(from decoder: Decoder) throws {
        let decoder = try decoder.container(keyedBy: CodingKeys.self)
        rateList = try decoder.decode([String: Double].self, forKey: .rateList)
    }
}
