//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 25/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let tableCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell//we've defined the identifier in the main storyboard for this ViewController screen
        
//                tableCell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet!"
                //self because this is the class that has all of the delegates methods that will deal with the deletion
                tableCell.delegate = self
                return tableCell
    }
    
    
    //addopted SwipeTableViewCellDelegate protocal in our category view controller
    //This code is responsible to handle when a user swipes any row of our category
    //our delete method triggers this delegate method cellForRowAt
    //which also triggers our self.updateModal method this method passes in the indexPath of the cell that got swipped
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            print("Item Deleted")
            self.updateModal(at: indexPath)
            //use if let (optional binding) to handle the Category or to pull results out of it
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-icon")

        return [deleteAction]
    }
        
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
//        options.transitionStyle = .border
        return options
    }
    
    func updateModal(at indexPath: IndexPath) {
        //update our data model //category
        print("Item deleted from super class")
    }
}
