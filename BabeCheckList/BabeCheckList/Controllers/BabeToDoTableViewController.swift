//
//  BabeToDoTableViewController.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/23/24.
//

import UIKit

class BabeToDoTableViewController: UITableViewController {

//    var itemArray = ["Workout","Eat Healthy", "Do Therapy"]
    
    /// UserDefaults = Are saved as a key value pair inside of a plist file. It can be saved as an array, string, dictionary
    
    /// USERDefaults: Step 1
//    let defaults = UserDefaults.standard
    
    
    var itemArray = [Item]()
    
    
    /// Creating the path for NSCoder - saving and retrieve  from
    let dataFilePath = FileManager.default.urls(
        for: .documentDirectory, 
        in: .userDomainMask).first?.appendingPathComponent("Items.plist")
       
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        loadItems()
        
        /// BarButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(UIbarButtonItem))
        
    
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
           
           
           var newItem = Item()
           newItem.title = textField.text!
           self.itemArray.append(newItem)
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
    
    /// Saving with NSCoder
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    /// Fetching the items in the ItemsArray 
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error loading")
            }
        }
    }
                                                                                          

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
