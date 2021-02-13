//
//  VideoSearchResponse.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

class VideoSearchResponse: Codable {
    var total_results: Int?
    var page: Int?
    var per_page: Int?
    var videos: [VideoObject]
    
}

class VideoObject: Codable {
   var id: Int?
    var width: Int?
    var height: Int?
    var url: String?
    var image: String?
    var duration: Int?
    var isFav: Bool?
    var user: User
    var video_files: [VideoFile]
    var video_pictures: [VideoPicture]
}

class User: Codable {
    var id: Int?
    var name: String?
    var url: String?
}

class VideoFile: Codable {
    var id: Int?
    var quality: String?
    var file_type: String?
    var width: Int?
    var height: Int?
    var link: String?
}

class VideoPicture: Codable {
    var id: Int?
    var picture: String?
    var nr: Int?
}
