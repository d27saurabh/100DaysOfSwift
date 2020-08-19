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
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
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
    
    @objc func startGame() {
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
            self?.submit(answer)
        }
        
        // add the created action to the alert controller
        ac.addAction(submitAction)
        
        //present the alert controller with animation
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()

        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .top)
                    
                    return
                } else {
                    showErrorMessage(errorTitle: "Word not recognized", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can'spell that word from \(title)")
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        if !word.isEmpty {
            for letter in word {
                if let position = tempWord.firstIndex(of: letter) {
                    tempWord.remove(at: position)
                } else {
                    return false
                }
            }
        } else {
            return false
        }
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(where: {$0.caseInsensitiveCompare(word) == .orderedSame}) && word != title
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound && word.count>=3
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

