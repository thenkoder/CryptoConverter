//
//  ContentInConvertedViewController.swift
//  Converter HW_3
//
//  Created by Другов Родион on 10.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: Protocol

protocol ButtonImageDelegate: AnyObject {
    var baseQuote: Quote? { get set }
    var convertQuote: Quote? { get set }
}

//MARK: Class

class ContentInConvertedViewController: UIViewController, ButtonImageDelegate {
    
    var baseQuote: Quote? {
        didSet {
            if let qoute = baseQuote, let image = UIImage(named: qoute.id)  {
                leftButtonImage.setImage(image, for: .normal)
                leftButtonImage.backgroundColor = nil
                leftButtonImage.titleLabel?.text = ""
                leftInfoLabel.text = "\(qoute.usdPrice)$"
                leftTF.text = ""
                rightTF.text = ""
            }
        }
    }
    
    var convertQuote: Quote? {
        didSet {
            if let qoute = convertQuote, let image = UIImage(named: qoute.id)  {
                rightButtonImage.setImage(image, for: .normal)
                rightButtonImage.backgroundColor = nil
                rightButtonImage.titleLabel?.text = ""
                rightInfoLabel.text = "\(qoute.usdPrice)$"
                leftTF.text = ""
                rightTF.text = ""
            }
        }
    }
    
    private var audioPlayer: AVAudioPlayer?
    
    //  MARK: Outlets
    
    @IBOutlet weak var leftButtonImage: UIButton!
    @IBOutlet weak var leftButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightButtonImage: UIButton!
    @IBOutlet weak var rightButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var leftTF: UITextField!
    @IBOutlet weak var rightTF: UITextField!
    
    @IBOutlet weak var rightInfoLabel: UILabel!
    @IBOutlet weak var leftInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Actions
    
    @IBAction func leftPressedButton(_ sender: UIButton) {
        addAnimationFor(sender)
        adding(.from)
    }
    
    @IBAction func rightPressedButton(_ sender: UIButton) {
        addAnimationFor(sender)
        adding(.to)
    }
    
    @IBAction func leftAddingText(_ sender: UITextField) {
        converter()
    }
    
    @IBAction func infoTitleItem(_ sender: Any) {
        infoAlert()
    }
    
    // MARK: Objc Funcions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: Functions
    
    
    
    private func converter() {
        let amount = Double(leftTF.text ?? "0")
        
        guard let convertQuote = convertQuote, let baseQuote = baseQuote else { return }
        
        rightTF.text = Converter.exchanger(amount: amount ?? 0, convertQuote: convertQuote, baseQuote: baseQuote)
    }
    
    private func addAnimationFor(_ sender: UIButton) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        
        pulse.duration = 0.4
        pulse.fromValue = 0.85
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 2.0
        
        sender.layer.add(pulse, forKey: "transform.scale")
    }
    
    private func adding(_ toOrFrom: QuotesSelected) {
        let secondTVC = storyboard?.instantiateViewController(withIdentifier: "quoteTVC") as! QuotesTableViewController
        secondTVC.quoteCurrency = toOrFrom
        secondTVC.buttonDelegate = self
        present(secondTVC, animated: true, completion: nil)
        
        addSound()
    }
    
    private func infoAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Here you can convert one cryptocurrency to another",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    private func addSound() {
        guard let pathToSound = Bundle.main.path(forResource: "buttonClick", ofType: "mp3") else { return }
        let url = URL(fileURLWithPath: pathToSound)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Sound is not started")
        }
    }
}

// MARK: Extension for TextField

extension ContentInConvertedViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

