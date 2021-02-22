//
//  CurrencyConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation
import SwiftUI
import Combine

class CurrencyConverterViewModel: ObservableObject, ExchangeRateFetchable {
    
    @Published var amount = "1"
    @Published var selectedCurrency: Currency?
    @Published var selectedCurrencySymbol = "USD"

    @Published var selectedCurrencyExchangeRate = ExchangeRate()
    @Published var convertedRates = [CurrencyConverter]()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var exchangeRates = [ExchangeRate]()
    
    private var disposables = Set<AnyCancellable>()
    
    init() {
        makeApicalls()
    }
    
    private func makeApicalls() {
        fetchCurrencies()
        fetchExchangeRatesRepeatatily()
        setupBinding()
    }
    
    private func setupBinding() {

        $amount
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global(qos: .userInitiated))
            .sink(
                receiveValue: { [weak self] value in
                    self?.reloadData()
                }
            )
            .store(in: &disposables)
        
        $selectedCurrency
            .sink(
                receiveValue: { [weak self] value in
                    if let symbol = value?.symbol {
                        self?.selectedCurrencySymbol = symbol
                    }
                    self?.fetchData()
                }
            )
            .store(in: &disposables)
    }
    
    private func fetchCurrencies() {
        
        self.currencyList().map { response in
            PersistentManager.shared.saveCurrencies(currencies: response.currencies)
        }
        .sink(
            receiveCompletion: { value in
                
                switch value {
                case .failure:
                    print("CurrencyList Api error:\(value)")
                case .finished:
                    break
                }
            },
            receiveValue: { _ in
            }
        )
        .store(in: &disposables)
        
    }
    
    
    private func fetchExchangeRatesRepeatatily() {
        fetchExchangeRates()
        //Call exchange rate api on every 30 minute
        Timer.scheduledTimer(withTimeInterval: 30 * 60, repeats: true) { [weak self] timer in
            self?.fetchExchangeRates()
        }
    }
    
    private func fetchExchangeRates() {
        
        self.exchangeRates().map { response in
            print("exchangeRates response:\(response.rateList)")
            PersistentManager.shared.saveExchangeRates(exchangeRates: response.rateList)
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { value in
                
                switch value {
                case .failure:
                    
                    print("ExchangeRates Api error:\(value)")
                case .finished:
                    
                    break
                }
            },
            receiveValue: { [weak self] currencies in
                self?.fetchData()
            })
        .store(in: &disposables)
    }
    
    private func fetchData() {
        exchangeRates = PersistentManager.shared.getExchangeRates()
        
        if let exchangeRate = fetchSelectedExchangeRate(exchangeRates) {
            selectedCurrencyExchangeRate = exchangeRate
            reloadData()
        }
        
    }
    
    private func reloadData()  {
        var results = [CurrencyConverter]()
        for exchangeRate in exchangeRates {
            let conversionRate = exchangeRate.rate / selectedCurrencyExchangeRate.rate
            let totalAmount = (Double(amount) ?? 0.0) * conversionRate
            let convertedAmount = String(format: "%.3f", totalAmount) + " \(exchangeRate.currencyName ?? "")"
            
            let currencyValue = "1 " + "\(selectedCurrencyExchangeRate.currencyName ?? "")" + " = " + String(format: "%.3f", conversionRate) + " \(exchangeRate.currencyName ?? "")"
            
            let currencyConversion = CurrencyConverter.init(convertedAmount: convertedAmount, currencyValue: currencyValue)
            
            results.append(currencyConversion)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.convertedRates = results
        }
    }
    
    private func fetchSelectedExchangeRate(_ exchangeRates: [ExchangeRate]) -> ExchangeRate? {
        
        let currencyName = selectedCurrencySymbol
        
        return exchangeRates.filter({
            
            return $0.currencyName == currencyName
        }).first
    }
    
}
