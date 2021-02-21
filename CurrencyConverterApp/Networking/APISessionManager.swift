//
//  APISessionManager.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation
import Combine

struct APISessionManager {
    
    static let session = URLSession(configuration: .default)
    
    private init() {}
    
   /* static func execute<T>(with components: URLComponents) -> AnyPublisher<T, CCError> where T: Decodable {
        guard let url = components.url else {
            let error = CCError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return APISessionManager.session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }*/
    
    static func execute<T>(with urlRequest: URLRequest?) -> AnyPublisher<T, CCError> where T: Decodable {
        guard let request = urlRequest else {
            let error = CCError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return APISessionManager.session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}



