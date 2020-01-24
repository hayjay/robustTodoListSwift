//
//  ViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 11/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//
import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]() //an array of strings
//    let defaults = UserDefaults.standard
    var selectedCategory : CategoryItem? {
        //didset gets executed as soon as selectedCategory gets set with a value
        didSet{
            loadItems()
        }
    }
    //set context globally in this class so we could access context throught the class in any function
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        loadItems()
        
        
        //as an array of Item from the item model
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
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
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)// the identifier is the name of the cell property we've given to the cell on the main.stryboard
        
        let todo_item = itemArray[indexPath.row]
        //then set the label for the cell
        tableCell.textLabel?.text = todo_item.title //current row of the current index path
        
        tableCell.accessoryType = todo_item.done == true ? .checkmark : .none
        
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
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        //this replaces the above if statements
        //it sets the done property of the current item to the opposite of the current status like toggle of a thing
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        //remove the data from our permanent stores
//        context.delete(itemArray[indexPath.row])
//        //remove the current selected item from the view
//        itemArray.remove(at: indexPath.row)
        
        //reload data one the status of the item gets updated
        //behind the scene what this does is that it forces the table view to call its data source method again
        //so that it reloads data thats meant to be inside
        
        self.saveItems()
        
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
            
            /*note that Item is our Entity (table) which comes from the CoreData
            Item automatically is a type of NSManagedObject which essentially represents a table row in our database which also means that every single row will be an NSManagedObject
             
             ALSO : NOTE THAT - Everytime we want to access our data from SQLite, we cant directly access the data without going through the context which basically serve as the model-interface between our application and the PersistentContainer(SQLite DB)
             **/
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            //set this to false to avoid error because our done field/column in CoreData is not set as optional!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            //after adding an item to the todo list, then reload the table view so it can get updated
            //with the new todo item
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //this would encode out data into a new property list folder
            self.saveItems()
            
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
    func saveItems() {
        //this would encode out data into a new property list folder
//        let encoder = PropertyListEncoder()
        
        do {
            //Here, remeber without the context as a middleman within the application and the PersistentContainer, we cant save directly to SQLite, so we have to call context to save the object
            try context.save()
            //encode out newly added todo item data into a .plist file
//            let data = try encoder.encode(itemArray)
            //save the data into our data file path
//            try data.write(to: dataFilePath!)
        } catch {
//            print("Error while encoding \(error)")
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    
//    func loadItems() {
//        //adding question mark at the fron of the try would turn the Data(Con.... into optional
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            //decode our todo item from the property list file
//            let decoder = PropertyListDecoder()//create new object of our decoder class
//            //the decoder.decode takes in what we want to decode which is our Item object
//            do {
//                //the second parameter is the data that we've unwrapped above which is data
//                itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("An error occurred while decoding todo data \(error)")
//            }
//        }
//    }
    
    //passing Item.fetchRequest incase this function is being called without any parameter
    //so it automatically makes request as Item.fetchRequest
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate] )
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            //the output of this method is going to be an array of items and its stored in our persistent container (DB)
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    //this function tells the delegate search button was tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        print(searchBar.text!)
        //in order to query object using core data, we need to use object called NSPredicate
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //sort or order the data retrieved from database
        //here we mean the title of each related search result from our database should contain
        //whatever the user has typed in the search bar
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //note that request.sortDescriptor expects an array of NSSortDescriptor
        //Load item to the view
        loadItems(with: request, predicate: predicate)
    }
    
    //another search bar delegate method that works just exactly like the onkey up
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //looks at number of characters in the string
        if searchBar.text?.count == 0 {
            /*this means if there is no search keyword anymor ein the search bar, then load the
            default ToDo items*/
            loadItems()
            //when the initial todo item has been realoaded to the page, we want to remove the search cursor and dismiss the keyboard from the view
            DispatchQueue.main.async { //simply run this method on the main queue
                searchBar.resignFirstResponder()
            }
           
        }
    }
}
