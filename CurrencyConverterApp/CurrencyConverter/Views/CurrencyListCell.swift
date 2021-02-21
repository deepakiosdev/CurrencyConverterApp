//
//  CurrencyListCell.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import SwiftUI
import Combine

struct CurrencyListCell: View {
    
    let currency: Currency
    @Binding var selectedCurrency: Currency?
    
    var body: some View {
        HStack {
            Text("\(currency.symbol ?? "")")
                .bold()
            
            Spacer()
            Text("\(currency.name ?? "")")
        } .onTapGesture {
            self.selectedCurrency = self.currency
        }
    }
}
