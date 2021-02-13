//
//  VideoListViewController.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController, StoryBoarded {

     @IBOutlet weak var videoListTable: UITableView!
    var viewModel: VideoListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.viewModel.outputDelegate = self
        videoListTable.dataSource = self
        videoListTable.delegate = self
        self.viewModel.initalizePagination()
        self.viewModel.keyword = "Dog"
        self.viewModel.fetchVideos(keyword: viewModel.keyword, pageNum: viewModel.pagination.pageNumber)

        // Do any additional setup after loading the view.
    }
    
    func registerCell() {
        videoListTable.register(UINib(nibName: "PhotoListTableViewCell", bundle: .main), forCellReuseIdentifier: "photoCell")
    }

}

extension VideoListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoListTableViewCell else { return UITableViewCell() }
        cell.updateUI(data: viewModel.videosArray[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(scrollView.bounds.maxY >= scrollView.contentSize.height){
            if viewModel.videosArray.count < viewModel.totalItems {
                viewModel.pagination.currentPageNumber = viewModel.pagination.pageNumber
                viewModel.pagination.pageNumber += 1
                viewModel.fetchVideos(keyword: viewModel.keyword, pageNum: viewModel.pagination.pageNumber)
            }
        }
    }
    
}

extension VideoListViewController: VideoListVMOutput {
    
    func reloadTableView() {
        DispatchQueue.main.async {
             self.videoListTable.reloadData()
        }
    }
}

extension VideoListViewController: Favorite {
    
    func favoriteAddedForItem(at index: Int) {
        if let isFav = self.viewModel.videosArray[index].isFav {
            self.viewModel.videosArray[index].isFav = !isFav
            if !isFav {
                CacheMemory.shared.favPhotosAndVideos.append( self.viewModel.videosArray[index])
            } else {
               CacheMemory.shared.favPhotosAndVideos.removeAll { (obj) -> Bool in
                    if let object = obj as? VideoObject {
                         return object.id == self.viewModel.videosArray[index].id
                    } else {
                        return false
                    }
                }
            }
        } else {
            self.viewModel.videosArray[index].isFav = true
             CacheMemory.shared.favPhotosAndVideos.append( self.viewModel.videosArray[index])
        }
        self.videoListTable.reloadData()
    }
}
