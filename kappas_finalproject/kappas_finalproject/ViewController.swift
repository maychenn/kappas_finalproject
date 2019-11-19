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
    func responseDataHandler(data: NSDictionary) {
        
    }
    
    func responseError(message: String) {
        
    }
  
    

}

