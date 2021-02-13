//
//  DataManager.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

class DataManager {
    
    class func fetchPhotos(pageNum: Int, keyword: String, completion: @escaping ((PhotoSearchResponse)) -> Void) {
        let urlString = "\(API.shared.baseUrl)/v1/search?query=\(keyword)&page=\(pageNum)&per_page=20"
        guard let url = URL(string: urlString) else { return }
        var result: PhotoSearchResponse?
        NetworkManager.performGetOperation(for: url, authorization: API.shared.apiToken) { (data) in
            do {
                result = try JSONDecoder().decode(PhotoSearchResponse.self, from: data)
            } catch {
                print("Failed To Decode \(error)")
            }
            if let details = result {
                completion(details)
            }
        }
    }
    
    class func fetchVideos(pageNum: Int, keyword: String, completion: @escaping ((VideoSearchResponse)) -> Void) {
        let urlString = "\(API.shared.baseUrl)/videos/search?query=\(keyword)&page=\(pageNum)&per_page=20"
        guard let url = URL(string: urlString) else { return }
        var result: VideoSearchResponse?
        NetworkManager.performGetOperation(for: url, authorization: API.shared.apiToken) { (data) in
            do {
                result = try JSONDecoder().decode(VideoSearchResponse.self, from: data)
            } catch {
                print("Failed To Decode \(error)")
            }
            if let details = result {
                completion(details)
            }
        }
    }
}

