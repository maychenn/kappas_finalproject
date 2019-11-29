//
//  RestaurantTableViewController.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/25/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit
import CoreData
import os.log

var restaurants: [NSManagedObject] = []
//var restaurant: NSManagedObject = NSManagedObject()

/*
class RestaurantTableViewController: UITableViewController  {
        
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
*/
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

        var name = restaurant.value(forKeyPath: "name") as! String
        var address = restaurant.value(forKeyPath: "address") as! String
        cell.nameLabel.text = "\(name)"
        cell.addressLabel.text = "\(address)"

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
                            
        let rest = restaurants[indexPath.row]
                            
        //cell.nameLabel.text = rest.name
        //cell.addressLabel.text = rest.address

<<<<<<< HEAD
        //cell.imageView.image = UIImage("like.png")
        print(cell.nameLabel.text)
=======
        cell.nameLabel?.text = restaurant.value(forKeyPath: "name") as? String
        cell.addressLabel?.text = restaurant.value(forKeyPath: "address") as? String
        //cell.imageView.image = UIImage("like.png")
                            
<<<<<<< HEAD
>>>>>>> parent of ab79bc9... some updates to main storyboard
=======
>>>>>>> parent of ab79bc9... some updates to main storyboard
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        do {
            let fetchedResults = try managedContext.fetch(fetchRequest)
            restaurants = fetchedResults
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchRestaurant(name:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToSelect:NSManagedObject = test[0]
            restaurant = objectToSelect
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

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
