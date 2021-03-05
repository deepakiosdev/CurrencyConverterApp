//
//  ApiRequestBuilder.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation


public enum APIRequestBuilder {
    case currencyList
    case exchangeRates
}

extension APIRequestBuilder: APIRequestConfiguration {
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return CurrencyLayerHostUrl
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
}

//Set request path
extension APIRequestBuilder {
    
    var path: String {
        
        switch self {
        case .currencyList:
            return "/list"
        case .exchangeRates:
            return "/live"
        }
    }
}

//Configure request Parameters
extension APIRequestBuilder {
    
    var requestParameters: [URLQueryItem]? {
         let requestParam = [
            URLQueryItem(name: "access_key", value: CurrencyLayerApiKey),
            URLQueryItem(name: "format", value: "1"),
         ]
         return requestParam
     }
}

//Create and configure URLRequest

extension APIRequestBuilder {
    
    func urlRequest() -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = scheme
        //components.m = httpMethod.rawValue
        components.host = host
        components.path = path
        components.queryItems = requestParameters
        
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
}
