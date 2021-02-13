//
//  Cache.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

class CacheMemory {
    static let shared = CacheMemory()
    var imageCache = [String: Any]()
    var urlCache = [String]()
    var favPhotosAndVideos = [Any]()
}
