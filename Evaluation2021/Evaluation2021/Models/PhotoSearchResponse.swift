//
//  PhotoSearchResponse.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

class PhotoSearchResponse: Codable {
    var total_results: Int
    var page: Int
    var per_page: Int
//    var next_Page: String
    var photos: [PhotoObject]
    
}

class PhotoObject: Codable {
    var id: Int
    var width: Int
    var height: Int
    var url: String
    var photographer: String
    var photographer_url: String
    var photographer_id: Int
    var avg_color: String
    var liked: Bool
    var isFav: Bool?
    var src: PhotoSource
}

class PhotoSource: Codable {
    var original: String
    var large2x: String
    var large: String
    var medium: String
    var small: String
    var portrait: String
    var landscape: String
    var tiny: String
}

