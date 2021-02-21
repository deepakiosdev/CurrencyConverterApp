//
//  CCError.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 20/02/21.
//

import Foundation

enum CCError: Error {
  case parsing(description: String)
  case network(description: String)
}
