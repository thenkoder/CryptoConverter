//
//  QuoteProvider.swift
//  Converter HW_3
//
//  Created by Другов Родион on 02.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class QuoteProvider {
    
    private var timer: Timer?
    private var timeInterval = 60.0
    private var quoteArray = [Quote]()
    
    private func sendNotification() {
        NotificationCenter.default.post(name: Notification.Name("sendQuoteArray"),
                                        object: quoteArray)
    }
    
    func restartTimer() {
        sendNotification()
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            self.loadQuotes()
        }
    }
    
    func loadQuotes() {
        guard let url = URL(string: "https://api.coinmarketcap.com/v1/ticker")  else  { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                if let quotes = try? JSONDecoder().decode([Quote].self, from: data) {
                    self.quoteArray = quotes
                    Storage.saveQuotes(quote: quotes)
                    DispatchQueue.main.async {
                        self.sendNotification()
                    }
                }
            }
        }
        dataTask.resume()
    }
}
    
    

