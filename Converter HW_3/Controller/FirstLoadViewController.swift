//
//  FirstLoadViewController.swift
//  Converter HW_3
//
//  Created by Другов Родион on 27.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class FirstLoadViewController: UIViewController {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blackView.layer.cornerRadius = blackView.frame.width / 6
        
        mainTextLabel.text = "Welcome to cryptoconverter." + "\n" +
                             "On the first tab, you can find out the cost of cryptocurrencies in the market." + "\n" +
                             "In the second tab, you can convert 1 cryptocurrency to another." + "\n" +
                             "The third tab contains information about the creator of the application."
        
    }
    
    @IBAction func pressedButton(_ sender: UIButton) {
        let secondTVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        present(secondTVC, animated: true, completion: nil)
    }
}
