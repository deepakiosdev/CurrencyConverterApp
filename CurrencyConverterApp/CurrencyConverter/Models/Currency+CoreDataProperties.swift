//
//  Currency+CoreDataProperties.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 21/02/21.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var name: String?
    @NSManaged public var symbol: String?

}

extension Currency : Identifiable {
}
