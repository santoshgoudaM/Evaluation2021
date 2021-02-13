//
//  MainCoordinator.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
            let vc = HomeViewController.instantiate()
            let vm = HomeViewModel(coordinator: self)
            vc.viewModel = vm
            self.navigationController.pushViewController(vc, animated: true)
    }
    
    func returnArrayOfVC() -> [UIViewController] {
        var array = [UIViewController]()
        let photoListVC = PhotoListViewController.instantiate()
        photoListVC.viewModel = PhotoListViewModel(coordinator: self)
        array.append(photoListVC)
        
        let videoListVC = VideoListViewController.instantiate()
        videoListVC.viewModel = VideoListViewModel(coordinator: self)
        array.append(videoListVC)
        
        let favListVC = FavouriteListViewController.instantiate()
        favListVC.viewModel = FavouriteListViewModel(coordinator: self)
        array.append(favListVC)
            
        return array
    }
}
