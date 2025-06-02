//
//  CategoryViewCell.swift
//  Todoey
//
//  Created by Jinfoappz on 28/05/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeCellTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            if let navBarBackgroundColor = UIColor(hexString: "1D9BF6") {
                updateNavBarColor(navBarBackgroundColor)
            }
        }
    
    //MARK: - Tableview Datasourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added yet"
        cell.backgroundColor =  UIColor(hexString: categories?[indexPath.row].colour ?? "#FFFFFF")
        cell.textLabel?.textColor = ContrastColorOf(UIColor(hexString: categories?[indexPath.row].colour ?? "#FFFFFF")!, returnFlat: true)
        
        return cell
    }
    
    //MARK: - Tableview Delegate method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo category", message: "", preferredStyle: .alert)
        
        let action =  UIAlertAction(title: "Add category", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "create new category"
            textField = alertTextField

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation
    func save(category: Category) {
        do {
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }

    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let nncategories = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(nncategories)
                }
            }catch{
                print("error while deleting category\(error)")
            }
        }
        
    }
}
