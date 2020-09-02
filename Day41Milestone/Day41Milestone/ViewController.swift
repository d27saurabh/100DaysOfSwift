//
//  ViewController.swift
//  Day41Milestone
//
//  Created by Saurabh Deshpande on 9/1/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    let hangmanText = ["H","A", "N", "G", "M", "A", "N"]
    var allWords = [String]()
    var usedWord = ""
    var guessedLetters = [String]()
    var guessedChars = [Character]()
    var promptTitle = ""
    var scoreLabel: UILabel!
    var guessTF: UITextField!
    var incorrectGuess = [UILabel]()
    var reveal: UIBarButtonItem!
    var submit: UIButton!
    var hangmanButtons = [UIButton]()
    var buttonsView: UIView!
    var wrongAnswers = 0
    let width = 30
    let height = 30
    
    // MARK: - loadView()
    override func loadView() {
        
        view = UIView()
        overrideUserInterfaceStyle = .dark
        
        // MARK: - score label
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 18)
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        // MARK: - guessTF
        guessTF = UITextField()
        guessTF.translatesAutoresizingMaskIntoConstraints = false
        guessTF.placeholder = "Shoot your LETTER"
        guessTF.textAlignment = .center
        guessTF.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(guessTF)
        
        // MARK: - submit button
        submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        // MARK: - buttons view
        buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        // MARK: - NSLayout Array
        NSLayoutConstraint.activate([
            //score label constraints
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            //guessTF constraints
            guessTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessTF.bottomAnchor.constraint(equalTo: submit.topAnchor, constant: -20),
            
            guessTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            //submit constraints
            submit.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submit.heightAnchor.constraint(equalToConstant: 24),
            
            buttonsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            buttonsView.centerXAnchor.constraint(equalTo: guessTF.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: guessTF.topAnchor, constant: -160),
        ])
        
        //create navigation buttons
        reveal = UIBarButtonItem(title: "Reveal", style: .plain, target: self, action: #selector(revealWord))
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareScore))
        navigationItem.leftBarButtonItem = reveal
        navigationItem.rightBarButtonItem = share
        
        //get contents of start.txt into allWords array
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        //handle if empty case
        if allWords.isEmpty {
            allWords = ["RHYTHM"]
        }
        startGame()
    }
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func startGame() {
        promptTitle = ""
        var disguisedTitle = ""
        guessedLetters.removeAll(keepingCapacity: true)
        wrongAnswers = 0
        
        hangmanButtons.removeAll(keepingCapacity: true)
        showHangman()
        
        usedWord = (allWords.randomElement())!.uppercased()
        print(usedWord)
        let lengthOfUsedWord = usedWord.count
        for _ in 0..<lengthOfUsedWord {
            disguisedTitle += "?"
        }
        title = disguisedTitle
    }
    
    func showHangman() {
        
        for subView in buttonsView.subviews {
            subView.removeFromSuperview()
        }
        
        for col in 0...6 {
            let hangmanButton = UIButton(type: .system)
            hangmanButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            hangmanButton.setTitle(hangmanText[col], for: .normal)
            let frame = CGRect(x: col * width, y: 1, width: width, height: height)
            hangmanButton.frame = frame
            buttonsView.addSubview(hangmanButton)
            hangmanButtons.append(hangmanButton)
        }
    }
    
    @objc func revealWord() {
        title = usedWord
        if score > 0 {
            score -= 1
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextWord))
        self.guessTF.isUserInteractionEnabled = false
        self.submit.isUserInteractionEnabled = false
        
    }
    
    @objc func nextWord() {
        startGame()
        navigationItem.leftBarButtonItem = reveal
        self.guessTF.isUserInteractionEnabled = true
        self.submit.isUserInteractionEnabled = true
    }
    
    
    @objc func shareScore() {
        let vc = UIActivityViewController(activityItems: ["Score: \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func submitTapped() {
        if guessTF.text!.isEmpty {
            let ac = UIAlertController(title: "Empty input", message: "Enter a letter to guess", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try Again", style: .cancel))
            present(ac, animated: true)
        } else if guessTF.text!.count > 1 {
            let ac = UIAlertController(title: "Multiple Letter Detected", message: "Enter a single letter to guess", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try Again", style: .cancel))
            present(ac, animated: true)
        } else if guessTF.text!.count == 1 {
            if usedWord.contains(String(guessTF.text!)) {
                if !guessedLetters.contains(guessTF.text!) {
                    score += 1
                    promptTitle = ""
                    guessedLetters.append(guessTF.text!)
                    for letter in usedWord {
                        let strLetter = String(letter)
                        if guessedLetters.contains(strLetter) {
                            promptTitle += strLetter
                        } else {
                            promptTitle += "?"
                        }
                    }
                    title = promptTitle
                }
            } else {
                if score > 0 {
                    score -= 1
                }
                wrongAnswers += 1
                hangmanButtons[wrongAnswers-1].setTitle(guessTF.text!, for: .normal)
                hangmanButtons[wrongAnswers-1].setTitleColor(.red, for: .normal)
                buttonsView.setNeedsDisplay()
                
                if wrongAnswers == 7 {
                    let ac = UIAlertController(title: "Hangman is dead", message: "Try again", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (_) in
                        self?.startGame()
                    }))
                    present(ac, animated: true)
                }
            }
            
            if promptTitle == usedWord {
                score += 10
                let ac = UIAlertController(title: "YAY!", message: "Let's try another", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
                    self?.startGame()
                }))
                present(ac, animated: true)
            }
        }
        guessTF.text = ""
    }
}

