//
//  ViewController.swift
//  Project5
//
//  Created by Saurabh Deshpande on 8/16/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //Properties
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the dark mode support
        overrideUserInterfaceStyle = .dark
        
        //create a new navigation bar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        //get contents of start.txt into allWords array
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    //number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    // cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    //navigation bar button method
    @objc func promptForAnswer() {
        
        //create a alert controller
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        
        //add a text field
        ac.addTextField()
        
        //create a ui alert action for submitting the answer
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit()
        }
        
        // add the created action to the alert controller
        ac.addAction(submitAction)
        
        //present the alert controller with animation
        present(ac, animated: true)
    }
    
    func submit() {
        
    }

}

