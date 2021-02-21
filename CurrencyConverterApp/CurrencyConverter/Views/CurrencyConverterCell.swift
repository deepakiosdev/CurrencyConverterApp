//
//  CurrencyConverterCell.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 21/02/21.
//

import SwiftUI


struct CurrencyConverterCell: View {
    private let currencyConverter: CurrencyConverter

    init(currencyConverter: CurrencyConverter) {
        self.currencyConverter = currencyConverter
    }
    
    var body: some View {
        
        VStack {
            
            if !currencyConverter.convertedAmount.isEmpty {
                
                Text(currencyConverter.convertedAmount)
                    .bold()
                    .font(.system(size: 18))
            }
                         
            Text(currencyConverter.currencyValue)
             .font(.system(size: 16))

            
        }.padding()
    }
}
