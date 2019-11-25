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
    func responseDataHandler(data:NSArray)
    func responseError(message:String)
}

class RestaurantDataSession {
    private let urlSession = URLSession.shared
    private let urlPathBase = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
    
    private var dataTask:URLSessionDataTask? = nil
    
    var delegate:RestaurantDataProtocol? = nil
    
    init() {}
    
    func getData(postString:String) {
        print(postString)
        //change url string
        var urlString = urlPathBase + postString + "&radius=1500&type=restaurant&key=AIzaSyCkdofYOJNxlwT510PckBABUKCKVYbTC98"
        
        let url:NSURL? = NSURL(string: urlString)
        
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
                let jsonResult2 = jsonResult!.value(forKey: "results") as? NSArray
                self.delegate?.responseDataHandler(data: jsonResult2!)
                print(jsonResult)
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
    
}
