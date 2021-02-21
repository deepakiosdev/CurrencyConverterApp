//
//  ApiRequestConfiguration.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation

/// A dictionary of parameters to apply to a `URLRequest`.
typealias Parameters = [String: Any]

protocol APIRequestConfiguration {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var requestParameters: [URLQueryItem]? { get }
   // var headers: Parameters? { get }

}



