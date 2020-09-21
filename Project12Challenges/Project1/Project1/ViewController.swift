//
//  ViewController.swift
//  Project1
//
//  Created by Saurabh Deshpande on 5/18/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var defaults = UserDefaults.standard
    var viewCount = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        overrideUserInterfaceStyle = .dark
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
            
            if let tempViewCount = defaults.object(forKey: "viewCount") as? [Int] {
                viewCount = tempViewCount
            } else {
                viewCount.append(0)
            }
        }
        pictures.sort()
        print(pictures)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        cell.detailTextLabel?.text = "Views: \(viewCount[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
            viewCount[indexPath.row] += 1
            defaults.setValue(viewCount, forKey: "viewCount")
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadData()
        }
    }
}

