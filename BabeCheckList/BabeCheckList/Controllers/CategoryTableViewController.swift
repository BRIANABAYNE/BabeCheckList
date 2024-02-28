//
//  CategoryTableViewController.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/27/24.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    
    // MARK: - Properties
    
    var categoryArray = [Category]()
    
    /// Step One of coreData ?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// Step 1 - CoreData ??
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        /// BarButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(UIBarButtonItemOne))
        
        title = "Babe, What do you need to do?"
    }
    
    
    @objc func UIBarButtonItemOne() {
        
        var textFiled = UITextField()
        

        let alert = UIAlertController(title: "What would you like to add?", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .destructive) {  (action) in
            
            
            let newItemInArray = Category(context: self.context)
            
            newItemInArray.name = textFiled.text!
            self.categoryArray.append(newItemInArray)
            self.saveItems()
            
        }

        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new item"
            textFiled = alertTextField
        }
        
        alert.addAction(action)
        print("alert is working")
        present(alert, animated: true)
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let item = categoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    
   
    
    
    // MARK: - Save and Load CoreData
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context,\(error)")
        }
    }
    
    
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray =  try context.fetch(request)
        } catch {
            printContent("Error fetching the data")
        }
        self.tableView.reloadData()
    }
}
