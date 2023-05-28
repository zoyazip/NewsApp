//
//  SavedTableViewController.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import UIKit
import CoreData

class SavedTableViewController: UITableViewController {
    
    var data: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func clearDataButton(_ sender: Any) {
        clearCoreData()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    func fetchCoreData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedNews")
            
            do {
                data = try managedContext.fetch(fetchRequest)
                tableView.reloadData()
            } catch {
                print("Error fetching data from Core Data: \(error.localizedDescription)")
            }
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as! SavedTableViewCell
        
        cell.savedLabel.text = data[indexPath.row].value(forKey: "title") as? String
        cell.savedPic.sd_setImage(with: URL(string: ((data[indexPath.row].value(forKey: "newsPicture") as? String ?? "https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=B4jML1jF"))))

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "savedSegue" {
                guard let destinationVC = segue.destination as? DetailViewController, let row = tableView.indexPathForSelectedRow?.row else { return
                }
                
                destinationVC.titleText = data[row].value(forKey: "title") as! String
                destinationVC.imageUrl = data[row].value(forKey: "newsPicture") as! String
                destinationVC.text = data[row].value(forKey: "content") as! String
                destinationVC.url = data[row].value(forKey: "url") as! String
                
            }
            
        }
    func clearCoreData() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedNews")
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try managedContext.execute(deleteRequest)
                
                // Clear the data array
                data = []
                
                tableView.reloadData()
                print("Core Data cleared successfully.")
            } catch {
                print("Error clearing Core Data: \(error.localizedDescription)")
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
