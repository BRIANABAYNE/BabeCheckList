//
//  BabeToDoTableViewController.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/23/24.
//

import UIKit
import CoreData

class BabeToDoTableViewController: UITableViewController {
    

//    var itemArray = ["Workout","Eat Healthy", "Do Therapy"]
    
    /// UserDefaults = Are saved as a key value pair inside of a plist file. It can be saved as an array, string, dictionary
    
    /// USERDefaults: Step 1
//    let defaults = UserDefaults.standard
    
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    /// Creating the path for NSCoder - saving and retrieve  from
    let dataFilePath = FileManager.default.urls(
        for: .documentDirectory, 
        in: .userDomainMask).first?.appendingPathComponent("Items.plist")
       
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// NSPredicate is a query language, it's a foundation class that specifies how data should be fetched or filtered.
    let request: NSFetchRequest<Item> = Item.fetchRequest()
      
        
        loadItems(with: request)
        configureSearchBar()
        
        /// BarButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(UIbarButtonItem))
        
    /// UserDefaults
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//            itemArray = items
//        }
//        
    }
                                                                                        
   @objc func UIbarButtonItem() {
       
       var textField = UITextField()
       
       /// Segue
//       let storyboard =  UIStoryboard(name: "Main", bundle: nil)
//       let segue = storyboard.instantiateViewController(withIdentifier: "babeDetailVC")
//       self.view.window?.rootViewController = segue
//       
       let alert = UIAlertController(title: "Babe, what do you need to do today?", message: "", preferredStyle: .alert)
       let action = UIAlertAction(title: "Add Item", style: .destructive) { (action) in
           
           /// Step 1 of CoreData after setting up class - moved this line of code to line 21 to access it in other places in this file
//           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           
           /// Step 1 - Custom Class Item
           let newItem = Item(context: self.context)
           
        
           newItem.title = textField.text!
           newItem.done = false
           self.itemArray.append(newItem)
           /// Calling the save for coreData
           self.saveItems()
           
           /// USERDefaults: Step 2
//           self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        
       }
       
       alert.addTextField { alertTextField in
           alertTextField.placeholder = "Add new item"
           textField = alertTextField
       }
       
       alert.addAction(action)
       print("alert is working")
       
       present(alert, animated: true)
       
        }
    
    
    func configureSearchBar() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Babe, what are you searching for?"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    
    
    /// Saving with NSCoder + CoreData - NSCoder is committed out
    func saveItems() {
        /// Encoder is for Codable Method for persisting and saving data into the plist
       // let encoder = PropertyListEncoder()
        
        do {
            
            try context.save()
            
           // let data = try encoder.encode(itemArray)
         //   try data.write(to: dataFilePath!)
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    /// Creating persistence for coreData - LOAD
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        /// Make sure to specify the data type <Item>
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
          itemArray = try context.fetch(request)
        } catch {
            print("Error fetching the data")
        }
    }
    
    
    
    /// Fetching the items in the ItemsArray - Codable
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//             //   itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error loading")
//            }
//        }
//    }
                                                                                          

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "babeCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        /// Ternary operator
        cell.accessoryType = item.done  ? .checkmark : .none
    
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
       
        /// Checked or not checked
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        /// Adds a chevron
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        /// When selected, it goes gray and then back to white
        tableView.deselectRow(at: indexPath, animated: true)
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Search Bar Methods

/// Extending the functionality - Handling the SearchBar Methods
extension BabeToDoTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        /// NSPredicate is a query language, it's a foundation class that specifies how data should be fetched or filtered.      
        ///  Refactoring code to use less code but keeping to reference
       // let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
       // request.predicate = predicate
        
        /// Refactor
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)

        
        /// OLD code
//        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
//        /// This property comes back as an array and that's why it's sortDescriptorS
//        request.sortDescriptors = [sortDescriptor]
        //request.sortDescriptors = [SortDescriptor]
        
        /// Refactor
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        /// Refactoring the code so I can use this code in other places on this file without writing it all out
//        do {
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching the data")
//        }
//        tableView.reloadData()
        
        loadItems(with: request)
    }
}
