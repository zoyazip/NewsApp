//
//  NetworkManager.swift
//  NewsApp
//
//  Created by d.chernov on 14/05/2023.
//

import Foundation

class NetworkManager{
    static func fetchData(completition: @escaping (News) -> () ){
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=apple&from=2023-05-13&to=2023-05-13&sortBy=popularity&apiKey=f5ee8a13db7b46f69da0c09c5d2ef6b3") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                print("Error+++", error!)
                return
            }
            
            print("Response", response as Any)
            
            guard let data = data else {return}
            do{
                let jsonData = try JSONDecoder().decode(News.self, from: data)
                completition(jsonData)
            }
            catch{
                print("Error+++ ", error)
            }
            
        }.resume()
    }
}
