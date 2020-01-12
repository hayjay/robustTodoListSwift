//
//  ViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 11/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Shola", "Fry Egg", "Recite Qur'an"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //CREATE THE TABLE VIEW DATA SOURCE METHODS : This methods should allow us to specify what the TABLE View cells should display
    //Also How many rows we want in our TABLE VIEW UI
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count //this is going to create three cells for us in our table view
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell that is going to be a reusable cell
        //index path is the current iteration (index)
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)// the identifier is the name of the cell property weve given to the cell on the main.stryboard
        
            
        //then set the label for the cell
        tableCell.textLabel?.text = itemArray[indexPath.row] //current row of the current index path
        
        return tableCell //teturn reach created table cell to the table view as a row on its own
    }
    
//    MARK - TableView Delegate Methods
    
//    This method gets fired whenever a user clicks any cell in the table
    //didSelectRowAt tells the delegate that the current row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //this helps add check mark to the selected todo item
        
        //checks if the currently selected todo item or cell has an accessory type of checkmark, if so then we want to remove the checkmark from it by changing it to none accessorytype
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
             tableView.cellForRow(at: indexPath)?.accessoryType = .none// the currently selected cell or todo
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //add animation after a user taps any cell then hides the grey color of the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
}

