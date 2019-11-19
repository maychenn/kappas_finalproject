//
//  RestaurantDataSession.swift
//  kappas_finalproject
//
//  Created by May Chen on 11/18/19.
//  Copyright © 2019 May Chen. All rights reserved.
//

import UIKit

protocol RestaurantDataProtocol
{
    func responseDataHandler(data:NSDictionary)
    func responseError(message:String)
}

class RestaurantDataSession {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1500&type=restaurant&key=AIzaSyCkdofYOJNxlwT510PckBABUKCKVYbTC98"
    
    private var dataTask:URLSessionDataTask? = nil
    
    var delegate:RestaurantDataProtocol? = nil
    
    init() {}
    
    func getData() {
        //change url string
        
        let url:NSURL? = NSURL(string: self.urlPathBase)
        
        let task = self.urlSession.dataTask(with: url! as URL) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
             
            do {
                var jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                print(jsonResult)
                /*
                let jsonResult2 = jsonResult!["data"] as? NSDictionary
                
                
                let jsonResult3 = try jsonResult2!["current_condition"] as? NSArray
                if jsonResult3 != nil {
                    var json = jsonResult3![0] as? NSDictionary
                
                
                    self.delegate?.responseDataHandler(data: json!)
                } else {
                    self.delegate?.responseError(message: "Current conditions not found")
                }
                 */
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
}
