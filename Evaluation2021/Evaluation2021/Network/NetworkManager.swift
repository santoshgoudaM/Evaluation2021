//
//  NetworkManager.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

class NetworkManager {
    
    class func performGetOperation(for url: URL,authorization : String? , completionHandler: @escaping (Data) -> Void){
        
        var request = URLRequest(url: url)
        
        if let auth = authorization {
            request.addValue(auth, forHTTPHeaderField: "authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            //Check if the data is valid
            guard let data = data else {
                return
            }
            guard let response = response else {
                print("response")
                return
            }
            //covert data to dictionary format (by using JSON serialization
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options:[]) as? [String:Any] else{
                    print("json")
                    return
                }
                completionHandler(data)
            }
            catch {
                print(error)
            }
        }.resume()
        //
        //        //Resume the task
        
    }
}

