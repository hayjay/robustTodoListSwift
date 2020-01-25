//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    //create a new access point to our realm database
    let realm = try! Realm()
    var categories : Results<Category>? //Whenever we query our realm database, the result we get back is always a Results object datatype from realm
    //serve as our CRUD interface to help us communicate with our persistent container(DB)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    //MARK: - TableView Data Source Methods
    /*Setup the data source so that we can display all of the categories in our persistent container
    to the table view */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if categories is not nill then return categories.count but if nill just return 1
        //we used a nil coaleasing operator here
        //if there is no categories at all, then we need a single cell or row to be produced
        //so that we would have the ability to display to the user that No categories added yet 
        return categories?.count ?? 1
    }
    //MARK: - Data Manipulation Methods namely : saveData and loadData
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("An error occured while saving category : \(error)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a reusable cell for our table view
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)//we've defined the identifier in the main storyboard for this ViewController screen
        tableCell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet!"
        return tableCell
    }
    
    //MARK: - Add Button Pressed IBAction in order to add a new category using our Category Entity
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        
        let alert_box = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = categoryTextField.text!

            //here we dont have to append new category to Realm DB anymore because automatically
            //what realm does is that whenever a realm field is being created or manipulated realm wathes for it and persist the data to the database
            //self.categories.append(newCategory)
            self.save(category : newCategory)
            
            self.tableView.reloadData()
        }
        
        alert_box.addAction(action)
        
        alert_box.addTextField { (field) in
            field.placeholder = "Add a new category"
            categoryTextField = field
            //push or save the user todo item to a global variable
        }
        
        //show the Alert viewcontroller pop-up modal
        present(alert_box, animated: true, completion: nil)
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
        //reload our table with the new data
        tableView.reloadData()
    }
    
    
    //MARK: - TableView Delegate Methods
    //this should happen when we click on one of the cells in the category table view
    //which should automatically load the Items view and display all related category items on the next screen
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "goToItems", sender : self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
}
