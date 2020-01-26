//
//  RateManager.swift
//  Converter HW_3
//
//  Created by Другов Родион on 06.01.2020.
//  Copyright © 2020 Другов Родион. All rights reserved.
//

import UIKit
import StoreKit

class RateManager {
    
    class func incrementCount() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        
        if count < 2 {
            UserDefaults.standard.set(count + 1, forKey: "run_count")
            UserDefaults.standard.synchronize()
        }
    }
    class func showRatesController() {
        let count = UserDefaults.standard.integer(forKey: "run_count")
        if count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                SKStoreReviewController.requestReview()
            }
        }
    }
}
