//
//  RestaurantTableViewController.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/25/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController {
    
    var restaurants: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Your Restaurants"
               tableView.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "Cell")
               
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return restaurants.count
    }
          
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RestaurantTableViewCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
                            
        let rest = restaurants[indexPath.row]
                            
        //cell.nameLabel.text = rest.name
        //cell.addressLabel.text = rest.address
        //cell.imageView.image = UIImage("like.png")
                            
        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    func saveRestaurant(name: String, address: String, liked: Bool) {
          
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
          
          // 1
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          // 2
          let entity =
            NSEntityDescription.entity(forEntityName: "Restaurant",
                                       in: managedContext)!
          
          let rest = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
          
          // 3
          rest.setValue(name, forKeyPath: "name")
          rest.setValue(address, forKeyPath: "address")
          rest.setValue(liked, forKeyPath: "liked")
          
          // 4
          do {
            try managedContext.save()
            restaurants.append(rest)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
            self.tableView.reloadData()
        }

    }
