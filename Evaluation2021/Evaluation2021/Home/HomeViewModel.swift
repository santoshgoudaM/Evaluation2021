//
//  HomeViewModel.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

protocol SearchItem {
    func getSearchedKeyword(keyword: String)
}

class HomeViewModel: BaseViewModel {
    let topTabBarDataSource = ["Photos", "Videos", "", "Favorites"]
    var searchPhotoDelegate: SearchItem?
    var searchVideoDelegate: SearchItem?
    
    
}
