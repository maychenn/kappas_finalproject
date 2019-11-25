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
     
    var dataSession = RestaurantDataSession()
    let locationManager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?

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
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let locations = "\(locValue.latitude),\(locValue.longitude)"
        self.dataSession.getData(postString: locations)
        print(locations)
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
        print(restaurantArray)
        print("found")
        
    }
   
    
    func responseError(message: String) {
    
    }
    
}

