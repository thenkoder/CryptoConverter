//
//  Storage.swift
//  Converter HW_3
//
//  Created by Другов Родион on 18.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import Foundation
import RealmSwift

class Storage {
    
    static func saveQuotes(quote: [Quote]) {
        guard let realm = try? Realm() else { return }
        quote
            .map { QuoteCached(quote: $0) }
            .forEach { quote in
                do {
                    
                    try realm.write {
                        realm.add(quote, update: .all)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
        }
    }
    
    static func readQuotesFromStorage() -> [Quote] {
        var cachedQuoteArray: [Quote] = []
        print("readQuotesFromStorage")
        do {
            let realm = try Realm()
            let results = realm.objects(QuoteCached.self)
            results
                .map { Quote(quote: $0) }
                .forEach { quote in
                    cachedQuoteArray.append(quote)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return cachedQuoteArray
    }
}


