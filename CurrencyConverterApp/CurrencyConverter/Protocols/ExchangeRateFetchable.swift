//
//  ExchangeRateFetchable.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation
import Combine


protocol ExchangeRateFetchable {
    
  func currencyList() -> AnyPublisher<CurrencyList, CCError>
  func exchangeRates() -> AnyPublisher<ExchangeRates, CCError>
}

extension ExchangeRateFetchable {
    
    func currencyList() -> AnyPublisher<CurrencyList, CCError> {
        return APISessionManager.execute(with: APIRequestBuilder.currencyList.urlRequest())
    }
     
    func exchangeRates() -> AnyPublisher<ExchangeRates, CCError> {
        return APISessionManager.execute(with: APIRequestBuilder.exchangeRates.urlRequest())
    }
    
}
