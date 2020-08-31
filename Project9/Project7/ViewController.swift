//
//  ViewController.swift
//  Project7
//
//  Created by Saurabh Deshpande on 8/22/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filterBarButton : UIBarButtonItem?
    var clearBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let credits = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = credits
        
        filterBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(filterOption))
        if let filterBarButton = filterBarButton {
            navigationItem.rightBarButtonItems = [filterBarButton]
        }
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: self, waitUntilDone: false)
        showError()
        
    }
    
    @objc func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; plese check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
       present(ac, animated:  true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Data is from", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterOption() {
        let ac = UIAlertController(title: "Filter topic", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let filterAction = UIAlertAction(title: "Filter", style: .default) {
            [weak self, weak ac] _ in
            guard let userString = ac?.textFields?[0].text else { return }
            self?.filterOn(userString)
        }
        ac.addAction(filterAction)
        present(ac, animated: true)
    }
    
    func filterOn(_ userString: String) {
        filteredPetitions.removeAll(keepingCapacity: true)
        for petition in petitions {
            if petition.title.lowercased().contains(userString.lowercased()) || petition.body.lowercased().contains(userString.lowercased()) {
                filteredPetitions.append(petition)
            }
        }
        clearBarButton = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearFilter))
        if let clearBarButton = clearBarButton {
            navigationItem.rightBarButtonItems = [clearBarButton]
            
        }
        
        
        tableView.reloadData()
    }
    
    @objc func clearFilter() {
        filteredPetitions.removeAll(keepingCapacity: true)
        filteredPetitions = petitions
        if let filterBarButton = filterBarButton {
            navigationItem.rightBarButtonItems = [filterBarButton]
            
        }
        tableView.reloadData()
    }
    
}

