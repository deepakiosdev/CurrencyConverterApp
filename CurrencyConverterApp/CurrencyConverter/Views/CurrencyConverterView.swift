//
//  CurrencyConverter.swift
//  CurrencyConverter
//
//  Created by Dipak Pandey on 20/02/21.
//

import SwiftUI

struct CurrencyConverterView: View {
    
    @ObservedObject var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        NavigationView {
            List {
                enterAmountSection
                selectCurrencySection
                exchangeRatesSection
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Currency Converter")
        }.onDisappear {
            UIApplication.shared.endEditing()
        }
    }
}
    

private extension CurrencyConverterView {
    var enterAmountSection: some View {
        HStack(alignment: .center) {
            TextField("Enter amount e.g. 7.00", text: $viewModel.amount)
                .offset(CGSize(width: 20.0, height: 0.0))
                .keyboardType(.decimalPad)
            
            Text(viewModel.selectedCurrencySymbol)
                .bold()
                .font(.system(size: 15))
        }
    }
    
    var selectCurrencySection: some View {
        Section {
            NavigationLink(destination: CurrencyListView.init(dismissed: { currency in
                viewModel.selectedCurrency = currency
            })) {
                HStack(alignment: .center) {
                    
                    Text("Select a Currency")
                        .bold()
                        .font(.system(size: 17))
                    
                    Spacer()
                    Text(viewModel.selectedCurrencySymbol)
                    
                }.padding()
            }
        }
    }
    
    
    var exchangeRatesSection: some View {
        Section {
            let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
            
            ScrollView() {
                
                LazyVGrid(columns: columns, alignment: .center) {
                    
                    ForEach(viewModel.convertedRates, content: CurrencyConverterCell.init(currencyConverter: ))
                        .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .cornerRadius(4.0)
                    }
                    
                }.font(.largeTitle)
            }
            
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterView()
    }
}
