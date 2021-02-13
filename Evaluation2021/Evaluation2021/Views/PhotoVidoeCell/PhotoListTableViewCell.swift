//
//  PhotoListTableViewCell.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit

protocol Favorite {
    func favoriteAddedForItem(at index: Int)
}
class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
     @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    var delegate: Favorite?
    var index = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClickFav(_ sender: Any) {
        delegate?.favoriteAddedForItem(at: self.index)
    }


    
    func updateUI(data: PhotoObject) {
        self.videoImage.isHidden = true
        self.nameLabel.text = data.photographer
        self.backgroundImage.loadImagesUsingURL(urlString: data.src.large)
        guard let isFav = data.isFav else { return }
        self.favButton.imageView?.image = isFav ? UIImage(named: "Favorite-home-select") :  UIImage(named: "Facorite_home-deselet")
    }
    
    func updateUI(data: VideoObject) {
        self.nameLabel.text = data.user.name
        if data.video_pictures.count > 0 {
            guard let url = data.video_pictures[0].picture else { return }
            self.backgroundImage.loadImagesUsingURL(urlString: url )
        }
        guard let isFav = data.isFav else { return }
        self.favButton.imageView?.image = isFav ? UIImage(named: "Favorite-home-select") :  UIImage(named: "Facorite_home-deselet")
     }
    
}



extension UIImageView {
    
    
    
    func loadImagesUsingURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        image = nil
        if let imageFromCache = CacheMemory.shared.imageCache[urlString] as? UIImage {
            self.image = imageFromCache
            return
        }
        
        if CacheMemory.shared.urlCache.contains(urlString) {
            return
        }
        CacheMemory.shared.urlCache.append(urlString)
        
        URLSession.shared.dataTask(with: url) { (data, respone, error) in
            if error != nil {
                print(error)
                return
            }
            DispatchQueue.main.async {
                let imageCache = UIImage.init(data: data!)
                CacheMemory.shared.imageCache[urlString] = imageCache
                self.image = imageCache
            }
        }.resume()
    }
}
