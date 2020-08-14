//
//  ViewController.swift
//  ConsolidationII
//
//  Created by Saurabh Deshpande on 8/13/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.


import UIKit

class ViewController: UITableViewController {
    var flags = [String]()
    var flagPicture = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        overrideUserInterfaceStyle = .dark
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        for item in items {
            if item.hasSuffix("@3x.png") {
                flagPicture.append(item)
                let trimmedItem = item.replacingOccurrences(of: "@3x.png", with: "").uppercased()
                flags.append(trimmedItem)
                print(trimmedItem)
            }
        }
        flags.sort()
        flagPicture.sort()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        //cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.layer.masksToBounds = true
        cell.textLabel?.text = flags[indexPath.row]
        cell.imageView?.layer.borderColor = UIColor.gray.cgColor
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.cornerRadius = 5
        
        cell.imageView?.image = UIImage(named: flagPicture[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.countryName = flags[indexPath.row]
            vc.flagName = flagPicture[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}

