//
//  ViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 11/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//
import UIKit
//import CoreData
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>? //an array of strings
    let realm = try! Realm()
//    let defaults = UserDefaults.standard
    var selectedCategory : Category? { //used ? at the front of model to check Category model is  not nil
        //didset gets executed as soon as selectedCategory gets set with a value
        didSet{
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    print(dataFilePath)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
//        let newItem = Item()
//        newItem.title = "Shola"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Kunle"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Wale"
        
//        loadItems()
        
        
        //as an array of Item from the item model
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        // Do any additional setup after loading the view.
    }
    
    //CREATE THE TABLE VIEW DATA SOURCE METHODS : This methods should allow us to specify what the TABLE View cells should display
    //Also How many rows we want in our TABLE VIEW UI
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create a cell that is going to be a reusable cell
        //index path is the current iteration (index)
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)// the identifier is the name of the cell property we've given to the cell on the main.stryboard
        
        if let todo_item = todoItems?[indexPath.row] {
            //then set the label for the cell
            tableCell.textLabel?.text = todo_item.title //current row of the current index path
            
            tableCell.accessoryType = todo_item.done == true ? .checkmark : .none
            
        } else {
            tableCell.textLabel?.text = "No Items Added"
        }
        
//        if todo_item.done == true {
//            tableCell.accessoryType = .checkmark
//        } else {
//            tableCell.accessoryType = .none
//        }
//
        return tableCell //teturn reach created table cell to the table view as a row on its own
    }
//    MARK - TableView Delegate Methods
    
//    This method gets fired whenever a user clicks any cell in the table
    //didSelectRowAt tells the delegate that the current row is now selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //check to see if todo item is not nil, if its not then we want to pick the indexPath current row of the item and assign it to the item variable
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
//                    realm.delete(item)
//                    toggle the previous status true to false and vice versa
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        //add animation after a user taps any cell then hides the grey color of the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - ADD NEW TODO ITEM
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("An error occured while saving todo item for \(self.selectedCategory) category : \(error)")
                }
                
            }
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
    
    //MARK - Model Manipulation Methods
//    func saveItems() {
//        //this would encode out data into a new property list folder
////        let encoder = PropertyListEncoder()
//
//        do {
//            //Here, remeber without the context as a middleman within the application and the PersistentContainer, we cant save directly to SQLite, so we have to call context to save the object
//            try context.save()
//            //encode out newly added todo item data into a .plist file
////            let data = try encoder.encode(itemArray)
//            //save the data into our data file path
////            try data.write(to: dataFilePath!)
//        } catch {
////            print("Error while encoding \(error)")
//            print("Error saving context \(error)")
//        }
//        tableView.reloadData()
//    }
    
    func loadItems() {
        //selectedcategory.items because selectedCategory has items properties
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
    }
    
    //passing Item.fetchRequest incase this function is being called without any parameter
    //so it automatically makes request as Item.fetchRequest
//    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
////        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate] )
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            //the output of this method is going to be an array of items and its stored in our persistent container (DB)
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        tableView.reloadData()
//    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {

//    //this function tells the delegate search button was tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            filter our todo list item
        //update todo item to be equal todo item filtered by the predicate
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        //sorted by title byKeyPath
        tableView.reloadData()
    }
//
//    //another search bar delegate method that works just exactly like the onkey up
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //looks at number of characters in the string
        if searchBar.text?.count == 0 {
            loadItems()
            /*this means if there is no search keyword anymor ein the search bar, then load the
            default ToDo items **/
            
           //when the initial todo item has been realoaded to the page, we want to remove the search cursor and dismiss the keyboard from the view
            DispatchQueue.main.async { //simply run this method on the main queue
                searchBar.resignFirstResponder()
            }
//
        }
    }
}
