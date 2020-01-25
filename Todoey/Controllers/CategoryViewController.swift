//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController{
    //create a new access point to our realm database
    let realm = try! Realm()
    //Note: Result<Category>? is an optional so when working with this object always use optional binding to handle it or to pull result out of it using the if let keyword
    var categories : Results<Category>? //Whenever we query our realm database, the result we get back is always a Results object datatype from realm
    //serve as our CRUD interface to help us communicate with our persistent container(DB)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        tableView.separatorStyle = .none
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
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
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
    
    //MARK: - Delete Data From Swipe
    //overriding means weve overriden how that method updateModal should work
    override func updateModal(at indexPath: IndexPath) {
        if let single_selected_category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(single_selected_category)
                }
            } catch {
                print("Error saving done status, \(error)")
            }
        }
                        //if a user did selected a row to delete, then lets relaod the categories data for this table view
//                        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a reusable cell for our table view
        //tapp into the superclass cell from superviewcontroller
        let cell = super.tableView(tableView, cellForRowAt: indexPath) //we setup a cell usind the superclass tableView method
        //get back the created cell from our superview controller and modify this created cell by changing the texts thats there dynamically
        //depending if there are records from the categories to be displayed if not then we rendered one cell with text : No categories added yet! to serve as the default
        
//        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet!"
            cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].colour ?? "1D9BF6")
//        }
        
        return cell
    }
    
    //MARK: - Add Button Pressed IBAction in order to add a new category using our Category Entity
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        
        let alert_box = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = categoryTextField.text!
            //append hexValue method to the color so we can get a string of the color back
            newCategory.colour = UIColor.randomFlat().hexValue()

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
