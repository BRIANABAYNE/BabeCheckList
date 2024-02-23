//
//  BabeToDoTableViewController.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/23/24.
//

import UIKit

class BabeToDoTableViewController: UITableViewController {

    var itemArray = ["Workout","Eat Healthy", "Do Therapy"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        /// BarButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(UIbarButtonItem))

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
           
           
           self.itemArray.append(textField.text!)
           self.tableView.reloadData()
       }
       
       alert.addTextField { alertTextField in
           alertTextField.placeholder = "Add new item"
           textField = alertTextField
       }
       
       alert.addAction(action)
       print("alert is working")
       
       present(alert, animated: true)
       
        }
                                                                                          

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "babeCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
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
        
        /// Adds a chevron
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
