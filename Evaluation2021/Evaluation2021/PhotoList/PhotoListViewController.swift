//
//  PhotoListViewController.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController, StoryBoarded {
    
     @IBOutlet weak var photoListTable: UITableView!
    var viewModel: PhotoListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.viewModel.outputDelegate = self
        photoListTable.dataSource = self
        photoListTable.delegate = self
        self.viewModel.initalizePagination()
        self.viewModel.keyword = "Dog"
        self.viewModel.fetchPhotos(keyword: viewModel.keyword, pageNum: viewModel.pagination.pageNumber)
    }

    func registerCell() {
        photoListTable.register(UINib(nibName: "PhotoListTableViewCell", bundle: .main), forCellReuseIdentifier: "photoCell")
    }

}

extension PhotoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoListTableViewCell else { return UITableViewCell() }
        cell.updateUI(data: viewModel.photosArray[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.bounds.maxY >= scrollView.contentSize.height){
            if viewModel.photosArray.count < viewModel.totalItems {
                viewModel.pagination.currentPageNumber = viewModel.pagination.pageNumber
                viewModel.pagination.pageNumber += 1
                viewModel.fetchPhotos(keyword: viewModel.keyword, pageNum: viewModel.pagination.pageNumber)
            }
        }
    }
    
}

extension PhotoListViewController: PhotoListVMOutput {
    
    func reloadTableView() {
        DispatchQueue.main.async {
             self.photoListTable.reloadData()
        }
    }
}

extension PhotoListViewController: Favorite {
    
    func favoriteAddedForItem(at index: Int) {
        if let isFav = self.viewModel.photosArray[index].isFav {
            self.viewModel.photosArray[index].isFav = !isFav
            if !isFav {
                CacheMemory.shared.favPhotosAndVideos.append( self.viewModel.photosArray[index])
            } else {
                CacheMemory.shared.favPhotosAndVideos.removeAll { (obj) -> Bool in
                    if let object = obj as? PhotoObject {
                         return object.id == self.viewModel.photosArray[index].id
                    } else {
                        return false
                    }
                }
            }
        } else {
            self.viewModel.photosArray[index].isFav = true
             CacheMemory.shared.favPhotosAndVideos.append( self.viewModel.photosArray[index])
        }
        self.photoListTable.reloadData()
    }
}
