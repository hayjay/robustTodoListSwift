//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 24/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [CategoryItem]()
    //serve as our CRUD interface to help us communicate with our persistent container(DB)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        loadCategories()
    }

    //MARK: - TableView Data Source Methods
    /*Setup the data source so that we can display all of the categories in our persistent container
    to the table view */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    
    
    //MARK: - Data Manipulation Methods namely : saveData and loadData
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("An error occured while saving category : \(error)")
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a reusable cell for our table view
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)//we've defined the identifier in the main storyboard for this ViewController screen
        
        tableCell.textLabel?.text = categories[indexPath.row].name
//        tableCell = categories[indexPath.row].name
        //set the label for the cell
//        tableCell.textLabel?.text = category_item.
        
        return tableCell
    }
    
    //MARK: - Add Button Pressed IBAction in order to add a new category using our Category Entity
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        
        let alert_box = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Save Category", style: .default) { (action) in
            let newCategory = CategoryItem(context: self.context)
            newCategory.name = categoryTextField.text!

            self.categories.append(newCategory)
            
            self.saveCategories()
            
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
    
    func loadCategories(request : NSFetchRequest<CategoryItem> = CategoryItem.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error fetching categories : \(error)")
        }
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
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
}
