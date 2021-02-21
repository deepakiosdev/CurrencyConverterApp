//
//  CurrencyListView.swift
//  CurrencyConverter
//
//  Created by Dipak Pandey on 20/02/21.
//

import SwiftUI
import Combine

struct CurrencyListView: View {
    
   @ObservedObject var viewModel = CurrencyListViewModel()
   @Environment(\.presentationMode) var presentationMode
    
    private var disposables = Set<AnyCancellable>()
    var callback: ((Currency?) -> Void)?

    init(dismissed callback: @escaping (Currency?) -> Void) {
        self.callback = callback
    }
    
    var body: some View {

        NavigationView {
            List {
                searchField
                if viewModel.currencies.isEmpty {

                    emptySection
                } else {
                    currencyListSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Currencies")
        }.onDisappear {
            UIApplication.shared.endEditing()
            self.callback!(viewModel.selectedCurrency)
        }
    }
    
}

  private extension CurrencyListView {
    var searchField: some View {
      HStack(alignment: .center) {
        TextField("Search currency by currency symbol. e.g. USD", text: $viewModel.searchedText)
      }
    }

    var currencyListSection: some View {
        Section {
            ForEach(viewModel.currencies, id: \.self) { currency in                
                CurrencyListCell.init(currency: currency) { currency in
                    viewModel.selectedCurrency = currency
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
        }
    }
    
    var emptySection: some View {
      Section {
        Text("No results")
          .foregroundColor(.gray)
      }
    }
}

