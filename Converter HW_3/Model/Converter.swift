//
//  Converter.swift
//  Converter HW_3
//
//  Created by Другов Родион on 10.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import Foundation

class Converter {
    var baseQuote: Quote
    
    init(baseQuote: Quote) {
        self.baseQuote = baseQuote
    }

    static func exchanger(amount: Double, convertQuote: Quote, baseQuote: Quote) -> String {
        
        guard let convertQuote = Double(convertQuote.usdPrice), let baseQuote = Double(baseQuote.usdPrice) else { return "" }
        
        let result = amount * convertQuote / baseQuote
        let string = String(format: "%.03f", result)
        return string
    }
}


