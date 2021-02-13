//
//  PhotoListViewModel.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import Foundation

protocol PhotoListVMOutput {
    func reloadTableView()
}
 
class PhotoListViewModel: BaseViewModel {
    var photosResopnse: PhotoSearchResponse?
    var photosArray = [PhotoObject]()
    var pagination = Pagination()
    var totalItems = 0
    var keyword = ""
    var outputDelegate: PhotoListVMOutput?
    
    func initalizePagination() {
        pagination.pageNumber = 1
        pagination.itemsPerPage = 20
    }
        
    func fetchPhotos(keyword: String, pageNum: Int) {
        DataManager.fetchPhotos(pageNum: pageNum, keyword: keyword) { (response) in
            if pageNum == 1 {
                self.photosResopnse = response
                 self.photosArray = response.photos
                self.totalItems = response.total_results
            } else {
                self.photosArray.append(contentsOf: response.photos)
            }
            self.outputDelegate?.reloadTableView()
        }
    }
}

extension PhotoListViewModel: SearchItem {
    func getSearchedKeyword(keyword: String) {
        if keyword == "" {
            return
        }
        self.keyword = keyword
        self.initalizePagination()
        self.fetchPhotos(keyword: keyword, pageNum: 1)
    }
}


