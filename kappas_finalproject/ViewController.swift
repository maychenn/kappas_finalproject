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
import CoreData

class ViewController: UIViewController, RestaurantDataProtocol, CLLocationManagerDelegate {
     
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var dataSession = RestaurantDataSession()
    let locationManager = CLLocationManager()
    var latitude : Double?
    var longitude : Double?
    var isLocationUpdated: Bool = false
    
    var name:String = ""
    var address:String = ""
    var liked:Bool = false
    
    var mapLatitude:Double?
    var mapLongitude:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get locations
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        // calls data session
        self.dataSession.delegate = self
    }
    // updates latitude & longitude
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (!isLocationUpdated) {
            isLocationUpdated = true
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let locations = "\(locValue.latitude),\(locValue.longitude)"
            self.latitude = locValue.latitude
            self.longitude = locValue.longitude
            
        // sends coordinates to dataSession
        self.dataSession.getData(postString: locations)
        }
    }
    
    var restaurantArray = [[String]]()
    
    @IBAction func noButton(_ sender: UIButton) {
        // restaurant alrdy seen
        if RestaurantTableViewController().searchData(name: restaurantNameLabel.text!) == true {
            RestaurantTableViewController().updateData(name: restaurantNameLabel.text!, liked: false)
        } else {    // not seen
            RestaurantTableViewController().saveRestaurant(name: restaurantNameLabel.text!, address: addressLabel.text!, liked: false)
            }
        self.generateRestaurant(restaurantArray: restaurantArray)
    }
    
    @IBAction func yesButton(_ sender: UIButton) {
        liked = true
        // not seen
        if RestaurantTableViewController().searchData(name: restaurantNameLabel.text!) == false {
            RestaurantTableViewController().saveRestaurant(name: restaurantNameLabel.text!, address: addressLabel.text!, liked: true)
            }
        else {  // seen
            RestaurantTableViewController().updateData(name: restaurantNameLabel.text!, liked: true)
        }

        }
    
    func getCoordinates(address:String) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemark = placemarks?.first,
                let CLLatitude = placemark.location?.coordinate.latitude,
                let CLLongitude = placemark.location?.coordinate.longitude
                else {
                    // handle no location found
                    return
                       }
            self.mapLatitude = CLLatitude
            self.mapLongitude = CLLongitude
           
        }}

    
    // gets the random restaurant data from dataSession
    func generateRestaurant(restaurantArray:[[String]]) {

        
        if self.restaurantArray.count <= 0 {
            self.restaurantNameLabel.text = "Sorry!"
            self.addressLabel.text = "No more restaurants found"
        }
        // checks that the json data has name and address
        if self.liked == false {
            var randNum = Int.random(in:0...(self.restaurantArray.count-1))
            var restaurant = self.restaurantArray[randNum]
            self.restaurantArray.remove(at: randNum)
            
            name = String(restaurant[0] as! String)
            address = String(restaurant[1] as! String)
            
            // updates the view labels
            self.restaurantNameLabel.text = name
            self.addressLabel.text = address
            
            // gets coordinates in case this is the selected restaurant
            getCoordinates(address: address)
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
        // gets a random restaurant
        DispatchQueue.main.async() {
            self.generateRestaurant(restaurantArray: self.restaurantArray)
        }
    }
    
    func responseError(message: String) {
    
    }


    override func prepare(for segue: UIStoryboardSegue,  sender: Any?) {
        if let presenter = segue.destination as? MapViewController {

            presenter.myLatitude = self.latitude!
            presenter.myLongitude = self.longitude!
            presenter.mapLatitude = self.mapLatitude!
            presenter.mapLongitude = self.mapLongitude!
            presenter.name = self.restaurantNameLabel.text!
            presenter.address = self.addressLabel.text!
            }
            
        }
        


}


