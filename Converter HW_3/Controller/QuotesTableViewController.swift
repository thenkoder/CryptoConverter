//
//  QuotesTableViewController.swift
//  Converter HW_3
//
//  Created by Другов Родион on 02.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit
import SwipeCellKit
import AVFoundation

// MARK: Enum

enum Constants {
    static let cellHeight: CGFloat = 100
    static var isSecondLaunch = "isSecondLaunch"
}

enum QuotesSelected {
    case from
    case to
}

// MARK: Class

class QuotesTableViewController: UITableViewController {
    
    private let quoteProvider = QuoteProvider()
    private var oldQuoteArray: [Quote] = []
    private var audioPlayer: AVAudioPlayer?
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredQuotes = [Quote]()
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var quotes: [Quote] = []
    var buttonDelegate: ButtonImageDelegate?
    var quoteCurrency: QuotesSelected = .from
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotes = Storage.readQuotesFromStorage()
                
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(generateTableContent(_:)),
                                               name: Notification.Name("sendQuoteArray"),
                                               object: nil)
        
        quoteProvider.restartTimer()
        quoteProvider.loadQuotes()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: Action
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        quoteProvider.loadQuotes()
        sender.endRefreshing()
        tableView.reloadData()
    }
    
    // MARK: Objc Funcion
    
    @objc func generateTableContent(_ notif: Notification) {
        
        if let quote = notif.object as? [Quote] {
            oldQuoteArray = quotes
            Storage.saveQuotes(quote: quote)
        }
        quotes = Storage.readQuotesFromStorage()
        
        tableView.reloadData()
    }
    
    // MARK: Functions
    
    
    
//    private func checkFirstLaunch() {
//
//            let alert = UIAlertController(title: "Hello!",
//                                          message: "Welcome to cryptoconverter." + "\n" +
//                                          "On the first tab, you can find out the cost of cryptocurrencies in the market." + "\n" +
//                                          "In the second tab, you can convert 1 cryptocurrency to another." + "\n" +
//                                          "The third tab contains information about the creator of the application.",
//                                          preferredStyle: .alert)
//            
//            let alertAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
//            
//            alert.addAction(alertAction)
//            
//            present(alert, animated: true, completion: nil)
//            
//            print("FIRST LAUNCH")
//    }
    
    // MARK: Create TableViewCell
    
    private func create(cell: QuoteCell, indexPath: IndexPath) {
        
        var quote: Quote
        
        if isFiltering {
            quote = filteredQuotes[indexPath.row]
        } else {
            quote = quotes[indexPath.row]
        }
        
//        let quote = quotes[indexPath.row]
        
        let oldQuote = oldQuoteArray.first { (oldQuote) -> Bool in
            oldQuote.id == quote.id
        }

        if let oldQuote = oldQuote {
            if let newQuoteUsd = Double(quote.usdPrice), let oldQuoteUsd = Double(oldQuote.usdPrice) {
                
                let percent = newQuoteUsd / oldQuoteUsd - 1
                let convert = "\(String(format: "%.5f", percent))%"
                
                if convert == "0.00000%" {
                    
                } else {
                    cell.id.text = "\(String(format: "%.5f", percent))%"
                    cell.id.textColor = percent > 0 ? .green : .red
                }
            }
        } else {
            cell.id.text = "0.00000%"
            cell.id.textColor = .blue
        }
        
        cell.name.text = quote.name
        cell.symbol.text = quote.symbol
        cell.price.text = "\(quote.usdPrice)" + "$"
        cell.imageView?.image = UIImage(named: quote.id)
        
        cell.delegate = self
    }
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredQuotes.count
        }
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! QuoteCell
        
        create(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let buttonDelegate = buttonDelegate {
            let quote = quotes[indexPath.row]
            
            if quoteCurrency == .from {
                buttonDelegate.baseQuote = quote
            } else {
                buttonDelegate.convertQuote = quote
            }
            dismiss(animated: true, completion: nil)
        } else {
            addSound()
            performSegue(withIdentifier: "toDetailVC", sender: indexPath)
        }
    }
    
    // MARK: AddSoundForCell
    
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
    
    // MARK: Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let quoteDetail = segue.destination as? QuoteDetailViewController {
            if let indexPath = sender as? IndexPath {
                let quot: Quote
                if isFiltering {
                    quot = filteredQuotes[indexPath.row]
                } else {
                    quot = quotes[indexPath.row]
                }
                quoteDetail.quote = quot
            }
            
        }
    }
}

// MARK: Extension

extension QuotesTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredQuotes = quotes.filter({ (quote: Quote) -> Bool in
            return quote.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}


