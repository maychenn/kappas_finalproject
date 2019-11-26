//
//  ViewController.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/11/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, RestaurantDataProtocol, CLLocationManagerDelegate {
     
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var dataSession = RestaurantDataSession()
    let locationManager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?
    var isLocationUpdated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        self.dataSession.delegate = self
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (!isLocationUpdated) {
            isLocationUpdated = true
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let locations = "\(locValue.latitude),\(locValue.longitude)"
        self.dataSession.getData(postString: locations)
    }
    }
    

    var counter: Bool = false
    var restaurantArray = [[String]]()

    @IBAction func noButton(_ sender: UIButton) {
        self.generateRestaurant(restaurantArray: restaurantArray)
       
    }
    
    @IBAction func yesButton(_ sender: UIButton) {
        counter = true
    
    }
    
    func generateRestaurant(restaurantArray:[[String]]) {
        if self.counter == false {
            var randNum = Int.random(in:0...(self.restaurantArray.count-1))
            var restaurant = self.restaurantArray[randNum]
            
            var found: Bool = false
            repeat {
                var randNum = Int.random(in:0...(self.restaurantArray.count))
                var restaurant = self.restaurantArray[randNum]
                if restaurant[0] == nil || restaurant[1] == nil {
                    self.restaurantArray.remove(at: randNum)
                } else {found = true}
            } while found == false
            
            var name:String = String(restaurant[0] as! String)
            var address:String = String(restaurant[1] as! String)
            
        
            self.restaurantNameLabel.text = name
            self.addressLabel.text = address
            
        }
    }
    func responseDataHandler(data: NSArray) {
        // parse through NSArray
        for result in data {
            var json = result as! NSDictionary
            let name = json.value(forKey: "name") as? NSString
            let location = json.value(forKey: "vicinity") as? NSString
            if name != nil && location != nil {
                let resultData = [String(name!), String(location!)] as [String]
            restaurantArray.append(resultData)
            }
        }
        
        
        DispatchQueue.main.async() {
            self.generateRestaurant(restaurantArray: self.restaurantArray)
            
        }
    }
   
    
    func responseError(message: String) {
    
    }
    
}

