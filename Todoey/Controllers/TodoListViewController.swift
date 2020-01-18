//
//  ViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 11/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//
import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]() //an array of strings
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Shola"
        newItem.done = true
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Kunle"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Wale"
        
        //as an array of string
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
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
        
        let todo_item = itemArray[indexPath.row]
        //then set the label for the cell
        tableCell.textLabel?.text = todo_item.title //current row of the current index path
        
        
        
        if todo_item.done == true {
            tableCell.accessoryType = .checkmark
        } else {
            tableCell.accessoryType = .none
        }
        
        return tableCell //teturn reach created table cell to the table view as a row on its own
    }
//    MARK - TableView Delegate Methods
    
//    This method gets fired whenever a user clicks any cell in the table
    //didSelectRowAt tells the delegate that the current row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        //this replaces the above if statements
        //it sets the done property of the current item to the opposite of the current status like toggle of a thing
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //reload data one the status of the item gets updated
        //behind the scene what this does is that it forces the table view to call its data source method again
        //so that it reloads data thats meant to be inside
        
        tableView.reloadData()
        
        //this helps add check mark to the selected todo item
        
        //checks if the currently selected todo item or cell has an accessory type of checkmark, if so then we want to remove the checkmark from it by changing it to none accessorytype
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//             tableView.cellForRow(at: indexPath)?.accessoryType = .none// the currently selected cell or todo
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//        
        //add animation after a user taps any cell then hides the grey color of the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - ADD NEW TODO ITEM
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what happens when the user clicks the item button on the UIAlert
//            print("Success")
            //append whatever the user typed in the text box to the todo array item list by pushing it to the array
            //force unwrap the text field because sometimes the text box is always empty or not
//            let newItem = Item()
//            newItem.title = textField.text!
//            self.itemArray.append(newItem)
            
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //after adding an item to the todo list, then reload the table view so it can get updated
            //with the new todo item
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        //This part adds a text box to the pop-up alert but we cant get
        //so we cant have the ability to get the user input because this is where the text box is being added to the alert box
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
            //push or save the user todo item to a global variable
        }
        alert.addAction(action)
        //show the Alert viewcontroller modal
        present(alert, animated: true, completion : nil)
    }
}