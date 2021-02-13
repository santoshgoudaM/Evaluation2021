//
//  VideoListViewModel.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

protocol VideoListVMOutput {
    func reloadTableView()
}
class VideoListViewModel: BaseViewModel {
    var videosResponse: VideoSearchResponse?
    var videosArray = [VideoObject]()
    var pagination = Pagination()
    var totalItems = 0
    var keyword = ""
    var outputDelegate: VideoListVMOutput?
    
    func initalizePagination() {
        pagination.pageNumber = 1
        pagination.itemsPerPage = 20
    }
        
    func fetchVideos(keyword: String, pageNum: Int) {
        DataManager.fetchVideos(pageNum: pageNum, keyword: keyword) { (response) in
            if pageNum == 1 {
                self.videosResponse = response
                 self.videosArray = response.videos
                self.totalItems = response.total_results ?? 0
            } else {
                self.videosArray.append(contentsOf: response.videos)
            }
            self.outputDelegate?.reloadTableView()
        }
    }
}

extension VideoListViewModel: SearchItem {
    func getSearchedKeyword(keyword: String) {
        if keyword == "" {
            return
        }
        self.keyword = keyword
        self.initalizePagination()
        self.fetchVideos(keyword: keyword, pageNum: 1)
    }
    
    
}
