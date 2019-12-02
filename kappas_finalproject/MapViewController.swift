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
    let annotation = MKPointAnnotation()
    
    var myLatitude: Double?
    var myLongitude: Double?
    var mapLatitude: Double?
    var mapLongitude: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: mapLatitude!, longitude: mapLongitude!)
        centerMapOnLocation(location: initialLocation)
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: mapLatitude!, longitude: mapLongitude!)
        mapView.addAnnotation(annotation)
        
        mapRoute()


    }
    
    let regionRadius: CLLocationDistance = 1500
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
      mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.lineWidth = 2.5
        renderer.strokeColor = UIColor.blue
        return renderer
        
    }
    
    func mapRoute() {
        print("trying to find the route")
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: myLatitude!, longitude: myLongitude!), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: mapLatitude!, longitude: mapLongitude!), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }

            for route in unwrappedResponse.routes {
                print("should be showing map")
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }

    }
    }
}
