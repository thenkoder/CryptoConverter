//
//  QuoteCell.swift
//  Converter HW_3
//
//  Created by Другов Родион on 02.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit
import SwipeCellKit

class QuoteCell: SwipeTableViewCell {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var symbol: UILabel!
}
