//
//  CurrencyListViewModel.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation
import Combine
import SwiftUI

class CurrencyListViewModel: ObservableObject, Identifiable {
    
    @Published var currencies: [Currency] = []
    @Published var searchedText = ""
    @Published var selectedCurrency: Currency?

    private var disposables = Set<AnyCancellable>()

    init() {
        setupBinding()
    }

    private func setupBinding() {
        $searchedText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global(qos: .userInitiated))
            .sink(receiveValue: searchCurrency(for:))
            .store(in: &disposables)
        
        $selectedCurrency
            .sink(receiveValue: { value in
                print("Selected Currency:\(String(describing: value))")
            }
            )
            .store(in: &disposables)
        
    }
    
    private func searchCurrency(for text: String) {
       let currencies = PersistentManager.shared.searchCurrencies(for: text)
        DispatchQueue.main.async { [weak self] in
            self?.currencies = currencies
        }
    }
    
}
