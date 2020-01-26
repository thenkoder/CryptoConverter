//
//  QuoteDetailViewController.swift
//  Converter HW_3
//
//  Created by Другов Родион on 02.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

// MARK: Class

class QuoteDetailViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var imageVC: UIImageView!
    @IBOutlet weak var nameLabelVC: UILabel!
    @IBOutlet weak var infoLabelVC: UILabel!
    @IBOutlet weak var scrollInfo: UIScrollView!
    
    var quote: Quote?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollInfo.addSubview(infoLabelVC)
        scrollInfo.contentSize = self.infoLabelVC.bounds.size
        
        showQuote()
    }
    
    // MARK: Function
    
    private func showQuote() {
        if let quote = quote {
            
            let date = Date(timeIntervalSince1970: Double(quote.lastUpdated) ?? 0.0)
            nameLabelVC.text = quote.name
            imageVC.image = UIImage(named: quote.id)
            
            infoLabelVC.text = "Name: \(quote.name)" + "\n" +
                               "Symbol: \(quote.symbol)" + "\n" +
                               "Rank: \(quote.rank)" + "\n" +
                               "Price usd: \(quote.usdPrice)$" + "\n" +
                               "Price btc: \(quote.btcPrice)$" + "\n" +
                               "24 hours volume usd: \(quote.twentyFourHoursVolumeUsd)$" + "\n" +
                               "Market cap usd: \(quote.marketCapUsd)$" + "\n" +
                               "Available supply: \(quote.availableSupply)" + "\n" +
                               "Total supply: \(quote.totalSupply)" + "\n" +
                               "Percent change 1h: \(quote.percentChangeOneH)%" + "\n" +
                               "Percent change 24h: \(quote.percentChangeTwentyFourH)%" + "\n" +
                               "Percent change 7d: \(quote.percentChangeSevenD)%" + "\n" +
                               "Last update: \(date)"
        }
    }
}





