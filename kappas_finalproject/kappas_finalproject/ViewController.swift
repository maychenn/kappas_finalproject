//
//  ViewController.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/11/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RestaurantDataProtocol {
    
    
    
    var dataSession = RestaurantDataSession()
         
    override func viewDidLoad() {
        super.viewDidLoad()
           
        self.dataSession.delegate = self
        self.dataSession.getData()
    }
    
    var restaurantArray = [[Any]]()
    func responseDataHandler(data: NSArray) {
        // parse through NSArray
        for result in data {
            var json = result as! NSDictionary
            let name = json.value(forKey: "name") as? NSString
            let price = json.value(forKey: "price_level") as? NSInteger
            let location = json.value(forKey: "vicinity") as? NSString
            let rating = json.value(forKey: "rating") as? NSString
            var resultData = [name, price, location, rating] as [Any]
            restaurantArray.append(resultData)
        }
    }
   
    
    func responseError(message: String) {
    
    }
    

}

