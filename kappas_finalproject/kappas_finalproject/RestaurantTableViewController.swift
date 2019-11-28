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
var restaurant: NSManagedObject = NSManagedObject()


class RestaurantTableViewController: UITableViewController {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        print(restaurants)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return restaurants.count
    }
          
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as! RestaurantTableViewCell
                            
        let restaurant = restaurants[indexPath.row]

        cell.nameLabel?.text = restaurant.value(forKeyPath: "name") as? String
        cell.addressLabel?.text = restaurant.value(forKeyPath: "address") as? String
        //cell.imageView.image = UIImage("like.png")
                            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // this function lets you delete by swiping left
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let restaurantToDelete = restaurants[indexPath.row]
            context.delete(restaurantToDelete)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        tableView.reloadData()
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
    
    
    func updateData(name: String, liked:Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            fetchRestaurant(name: name)
            restaurant.setValue(liked, forKey: "liked")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not update. \(error), \(error.userInfo)")
        }
    }
    
    func searchData(name: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)

        var results: [NSManagedObject] = []

        do {
            results = try managedContext.fetch(fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return results.count > 0
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
