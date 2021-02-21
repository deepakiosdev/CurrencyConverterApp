//
//  PersistentManager.swift
//  CurrencyConverterApp
//
//  Created by Dipak Pandey on 21/02/21.
//

import Foundation
import CoreData
import SwiftUI

struct PersistentManager {
   
    static let shared = PersistentManager()
        
    let persistentContainer: NSPersistentContainer

    // MARK: - Core Data stack
    private init() {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        persistentContainer = NSPersistentContainer(name: "CurrencyConverterApp")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


extension PersistentManager {
    
    func deleteAllObjects(_ entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Core data delete error:\(error)")
        }
    }
    
    func saveCurrencies(currencies: [String : String]) {
        
        if currencies.count > 0 {
            deleteAllObjects("Currency")
            
            for (symbol, name) in currencies {
                let currency = Currency(context: persistentContainer.viewContext)
                currency.symbol = symbol
                currency.name = name
            }
            saveContext()
        }
    }
    
    func saveExchangeRates(exchangeRates: [String : Double]) {
        
        if exchangeRates.count > 0 {
            
            deleteAllObjects("ExchangeRate")
            
            for (currencyName, rate) in exchangeRates {
                let exchangeRate = ExchangeRate(context: persistentContainer.viewContext)
                
                //Remove USD prefix from currency name
                let prefix = "USD"
                var currency = currencyName
                if currency.count > prefix.count {
                    currency = String(currency.dropFirst(prefix.count))
                }

                exchangeRate.currencyName = currency
                exchangeRate.rate = rate
            }
            saveContext()
        }
    }
    
    
    func searchCurrencies(for serachText: String ) -> [Currency] {
        let fetchRequest: NSFetchRequest<Currency> = Currency.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "symbol", ascending: true)]
        if !serachText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "symbol contains[c] %@", serachText)
        }
        return try! persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    func getExchangeRates() -> [ExchangeRate] {
        let fetchRequest: NSFetchRequest<ExchangeRate> = ExchangeRate.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "currencyName", ascending: true)]
        return try! persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    
}
