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
    
    
    // MARK: - Life cycles methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //support dark mode
        overrideUserInterfaceStyle = .dark
        
        //add '+' button to the right of the navigation bar
        let addUIBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemsToList))
        
        // add share button to the right of the navigation bar
        let shareUIBarbutton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        
        //add + and share to the right of the navigation bar
        navigationItem.rightBarButtonItems = [addUIBarButton, shareUIBarbutton]
        
        //add Clear button to the left of the navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
        
        //set title
        title = "Shopping List"
        
    }
    
    // MARK: - UI bar button methods
    
    // + button method - add items to the table view
    @objc func addItemsToList() {
        showAlertToAddItem()
    }
    
    @objc func shareList() {
        
        //add all the items from the shopping list array to string
        let list = shoppingList.joined(separator: "\n")
        
        //share the list
        let activityViewController = UIActivityViewController(activityItems: [list], applicationActivities: [])
        activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activityViewController, animated: true)
    }
    
    // Clear button method - clears the shopping list
    @objc func clearList() {
        //remove all items from the shopping list
        shoppingList.removeAll(keepingCapacity: true)
        
        //update the table view
        tableView.reloadData()
    }
    
    
    
    // MARK: - Alert to add item methods
    
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
    
    // MARK: - Table view methods
    
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

