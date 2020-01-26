//
//  TabBarController.swift
//  Converter HW_3
//
//  Created by Другов Родион on 28.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RateManager.showRatesController()
    }
}

