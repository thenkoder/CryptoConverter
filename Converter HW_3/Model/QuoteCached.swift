//
//  QuoteCached.swift
//  Converter HW_3
//
//  Created by Другов Родион on 17.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers
class QuoteCached: Object {
    
    dynamic var id = ""
    dynamic var name = ""
    dynamic var symbol = ""
    dynamic var rank = 0
    dynamic var usdPrice = ""
    dynamic var btcPrice = ""
    dynamic var twentyFourHoursVolumeUsd = ""
    dynamic var marketCapUsd = ""
    dynamic var availableSupply = ""
    dynamic var totalSupply = ""
    dynamic var maxSupply: String?
    dynamic var percentChangeOneH = ""
    dynamic var percentChangeTwentyFourH = ""
    dynamic var percentChangeSevenD = ""
    dynamic var lastUpdated = ""
    
    override class func primaryKey() -> String? {
        return "rank"
    }
    
    convenience init(quote: Quote) {
        self.init()
        self.id = quote.id
        self.name = quote.name
        self.symbol = quote.symbol
        self.rank = Int(quote.rank) ?? 0
        self.usdPrice = quote.usdPrice
        self.btcPrice = quote.btcPrice
        self.twentyFourHoursVolumeUsd = quote.twentyFourHoursVolumeUsd
        self.marketCapUsd = quote.marketCapUsd
        self.availableSupply = quote.availableSupply
        self.totalSupply = quote.totalSupply
        self.maxSupply = quote.maxSupply
        self.percentChangeOneH = quote.percentChangeOneH
        self.percentChangeTwentyFourH = quote.percentChangeTwentyFourH
        self.percentChangeSevenD = quote.percentChangeSevenD
        self.lastUpdated = quote.lastUpdated
    }
}

