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
    var callback: ((Currency?) -> Void)?
   
    init(currency: Currency, callback: @escaping (Currency?) -> Void) {
        self.currency = currency
        self.callback = callback
    }
    
    var body: some View {
        HStack {
            Text("\(currency.symbol ?? "")")
                .bold()
            
            Spacer()
            Text("\(currency.name ?? "")")
        } .onTapGesture {
            self.callback!(currency)
        }
    }
}
