//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework
class ToDoViewController: SwipeCellTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var items: Results<Item>?
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            
        super.viewWillAppear(animated)
        
        if let colourHex = selectedCategory?.colour {
            title = selectedCategory!.name
            guard (navigationController?.navigationBar) != nil else { fatalError("Navigation controller does not exist.")
            }
            if let navBarColour = UIColor(hexString: colourHex) {
                
                updateNavBarColor(navBarColour)
                
                searchBar.searchTextField.backgroundColor = FlatWhite()
                searchBar.barTintColor = navBarColour
            }
        }
    }
    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let message = items?[indexPath.row]{
            cell.textLabel?.text = message.title
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
            if let colour = UIColor(hexString: selectedCategory!.colour)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(items!.count)) {
                
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            cell.accessoryType = message.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = items?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
                }
            }catch{
                print("error while updating \(error)")
            }
        }
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItemGroup){
        
        var textField = UITextField()
            
            let alert = UIAlertController(title: "Add new todo item", message: "", preferredStyle: .alert)
            
            let action =  UIAlertAction(title: "Add item", style: .default) { (action) in
                
                if let currentCategory = self.selectedCategory{
                    do {
                        try self.realm.write {
                            let newItem = Item()
                            newItem.title = textField.text!
                            newItem.dateCreated = Date()
                            currentCategory.items.append(newItem)
                        }
                    } catch {
                        print("Error writing to Realm: \(error)")
                    }

                    self.tableView.reloadData()
                }
            }
            
            alert.addTextField { alertTextField in
                alertTextField.placeholder = "create new item"
                textField = alertTextField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manipulation
    func loadItems() {
        
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //delete items
    override func updateModel(at indexPath: IndexPath) {
        if let nnitems = self.items?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(nnitems)
                }
            }catch{
                print("error while deleting item\(error)")
            }
        }
    }
}

//MARK: - SearchBar Delegate
extension ToDoViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == ""{
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        } else {
            searchBarSearchButtonClicked(searchBar)
        }
    }
}
