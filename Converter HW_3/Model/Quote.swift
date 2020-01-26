//
//  Quote.swift
//  Converter HW_3
//
//  Created by Другов Родион on 02.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit
import RealmSwift

class Quote: Decodable {
    
    var id = ""
    var name = ""
    var symbol = ""
    var rank = ""
    var usdPrice = ""
    var btcPrice = ""
    var twentyFourHoursVolumeUsd = ""
    var marketCapUsd = ""
    var availableSupply = ""
    var totalSupply = ""
    var maxSupply: String?
    var percentChangeOneH = ""
    var percentChangeTwentyFourH = ""
    var percentChangeSevenD = ""
    var lastUpdated = ""
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case usdPrice = "price_usd"
        case btcPrice = "price_btc"
        case twentyFourHoursVolumeUsd = "24h_volume_usd"
        case marketCapUsd = "market_cap_usd"
        case availableSupply = "available_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case percentChangeOneH = "percent_change_1h"
        case percentChangeTwentyFourH = "percent_change_24h"
        case percentChangeSevenD = "percent_change_7d"
        case lastUpdated = "last_updated"
    }
    
    convenience init(quote: QuoteCached) {
        self.init()
        self.id = quote.id
        self.name = quote.name
        self.symbol = quote.symbol
        self.rank = String(quote.rank)
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


