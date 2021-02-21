//
//  ExchangeRate+CoreDataProperties.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 21/02/21.
//
//

import Foundation
import CoreData


extension ExchangeRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRate> {
        return NSFetchRequest<ExchangeRate>(entityName: "ExchangeRate")
    }

    @NSManaged public var currencyName: String?
    @NSManaged public var rate: Double

}

extension ExchangeRate : Identifiable {

}
