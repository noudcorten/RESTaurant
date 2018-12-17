//
//  MenuController.swift
//  RESTaurant App
//
//  Created by Noud on 5-12-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation
import UIKit

// MARK: menucontroller class which has all the functions that communicate with the server
class MenuController {
    static let shared = MenuController()
    
    let baseURL = URL(string: "https://resto.mprog.nl/")!

    // MARK: fetches all the categories on the server
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // MARK: fetches all the menu items for the given category
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let menuArray = jsonDictionary?["items"] as? [[String: Any]] {
                let menuItems = menuArray.flatMap { MenuItem(json: $0) }
                completion(menuItems)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    // MARK: submits the order if the user is done selecting menuItems
    func fetchSubmitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let data: [String: Any] = ["menuIds": menuIds]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])

        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let prepTime = jsonDictionary?["preparation_time"] as? Int {
                completion(prepTime)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        
    }
    
    // MARK: fetches the image to the corresponding meal
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}
