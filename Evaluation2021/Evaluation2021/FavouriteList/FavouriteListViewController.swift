//
//  FavouriteListViewController.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit

class FavouriteListViewController: UIViewController, StoryBoarded {
    
    @IBOutlet weak var favListTable: UITableView!
    var viewModel: FavouriteListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        self.favListTable.dataSource = self
        self.favListTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favListTable.reloadData()
    }
    
    func registerCell() {
        favListTable.register(UINib(nibName: "PhotoListTableViewCell", bundle: .main), forCellReuseIdentifier: "photoCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavouriteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CacheMemory.shared.favPhotosAndVideos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoListTableViewCell else { return UITableViewCell() }
        
        if let photoObj = CacheMemory.shared.favPhotosAndVideos[indexPath.row] as? PhotoObject {
            cell.updateUI(data: photoObj)
        } else if let videoObj = CacheMemory.shared.favPhotosAndVideos[indexPath.row] as? VideoObject {
            cell.updateUI(data: videoObj)
        }
        
        cell.index = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
}

extension FavouriteListViewController: Favorite {
    
    func favoriteAddedForItem(at index: Int) {
        
    }
    
    
}
