//
//  ViewController.swift
//  Project2
//
//  Created by Saurabh Deshpande on 8/10/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //IBOulets for 3 buttons
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //for dark mode
        
        overrideUserInterfaceStyle = .dark
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " \(score)"
        questionsAsked += 1
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        askQuestion()
        
        
//        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
//
//        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
//
//        present(ac, animated: true)
        
        if questionsAsked % 10 == 0 {
            let am = UIAlertController(title: "Final Score", message: "\(score)", preferredStyle: .alert)
            am.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(am, animated: true)
            score = 0
        }
    }
    
    // Challenge 3: Go back to project 2 and add a bar button item that shows their score when tapped.
    @objc func showScore() {
        let am = UIAlertController(title: "Final Score", message: "\(score)", preferredStyle: .alert)
        am.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(am, animated: true)
        
//        let scoreAlert = UIAlertController(title: "SCORE", message: nil, preferredStyle: .actionSheet)
//        scoreAlert.addAction(UIAlertAction(title: "Your current score is \(score)", style: .default, handler: nil))
//        present(scoreAlert, animated: true)
    }

}

