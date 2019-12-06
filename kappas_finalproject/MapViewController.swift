//
//  MapViewController.swift
//  kappas_finalproject
//
//  Created by Christina Hoang on 11/25/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit
import MapKit


class MapViewController:UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let annotation = MKPointAnnotation()
    
    
    var myLatitude: Double?
    var myLongitude: Double?
    var mapLatitude: Double?
    var mapLongitude: Double?
    var name: String?
    var address: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: mapLatitude!, longitude: mapLongitude!)
        self.centerMapOnLocation(location: initialLocation)
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapLatitude!, longitude: mapLongitude!)
        mapView.addAnnotation(annotation)
        
        mapRoute()


    }
    
    let regionRadius: CLLocationDistance = 10000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        //let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
        
    }
    
    func mapRoute() {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: myLatitude!, longitude: myLongitude!), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: mapLatitude!, longitude: mapLongitude!), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)

        directions.calculate { response, error in
            
            let routes = response?.routes
            let selectedRoute = routes![0]
            
            var distanceMeters = selectedRoute.distance
            distanceMeters = distanceMeters * 0.000621371192
            
            var eta = selectedRoute.expectedTravelTime
            eta = eta / 60 // converts to minutes
            
            let distance = "\(String(format: "%.2f", distanceMeters)) miles"
            
            var travelTime = ""
            if eta >= 60 {
                var hours = eta / 60
                hours.round(.down)
                let minutes = eta / 60
                travelTime = "\(Int(hours)) hours \(String(format: "%.2f", minutes)) minutes"
            }
            else {
                travelTime = "\(String(format: "%.2f", eta)) minutes"
            }
            print(distance)
            print(travelTime)
            self.restaurantNameLabel.text = self.name
            self.addressLabel.text = self.address
            self.distanceLabel.text = distance
            self.timeLabel.text = travelTime
             self.mapView.addOverlay(selectedRoute.polyline, level: MKOverlayLevel.aboveRoads)
            self.mapView.setVisibleMapRect(selectedRoute.polyline.boundingMapRect, animated: true)
            
            
            /*
            guard let unwrappedResponse = response else { return }
             
            for route in unwrappedResponse.routes {
                print("should be showing map")
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            */
    }
    }
    
    func mapView(_ ProfileMapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        if annotation.isMember(of: MKUserLocation.self) {
            return nil
        }

        let reuseId = "PinView"

        var pinView = ProfileMapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)}
        pinView!.canShowCallout = true

        let newPin = self.resizeImage(image: UIImage(named: "pin")!, targetSize: CGSize(width: 50.0, height: 50.0))
        pinView!.image = newPin
        
        return pinView

    }
     func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}
