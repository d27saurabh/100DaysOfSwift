//
//  ViewController.swift
//  Day32Milestone
//
//  Created by Saurabh Deshpande on 8/21/20.
//  Copyright © 2020 Saurabh Deshpande. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //support dark mode
        overrideUserInterfaceStyle = .dark
        
        //add '+' button to the right of the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemsToList))
        
        //set title
        title = "Shopping List"
        
    }
    
    // + button method - add items to the table view
    @objc func addItemsToList() {
        showAlertToAddItem()
    }
    
    //alert to add item
    func showAlertToAddItem() {
        let alertControllerToAddItem = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        
        //add text field to the alert controller
        alertControllerToAddItem.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak alertControllerToAddItem] _ in
            guard let itemToAdd = alertControllerToAddItem?.textFields?[0].text else { return }
            self?.add(itemToAdd)
        }
        
        //add add button
        alertControllerToAddItem.addAction(addItemAction)
        
        //present the alert controller with animation
        present(alertControllerToAddItem, animated: true)
    }
    
    
    //logic for add button in alert controller
    func add(_ item: String) {
        // add item to the end of the shopping list
        shoppingList.insert(item, at: 0)
        
        //create indexPath
        let indexPath = IndexPath(row: 0, section: 0)
        
        //insert in the table view
        tableView.insertRows(at: [indexPath], with: .fade)
        
    }
    
    // table view method to get number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    //table view method to display at each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    
    
}

