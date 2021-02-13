//
//  MenuBarCollectionViewCell.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 13/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isHighlighted: Bool {
        didSet {
            titleLabel.textColor = isHighlighted ? UIColor(red: 232.0/255.0, green: 18.0/255.0, blue: 68.0/255.0, alpha: 1.0) : UIColor.darkGray
            indicatorView.backgroundColor = isHighlighted ? UIColor(red: 232.0/255.0, green: 18.0/255.0, blue: 68.0/255.0, alpha: 1.0) : UIColor.white
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor(red: 232.0/255.0, green: 18.0/255.0, blue: 68.0/255.0, alpha: 1.0) : UIColor.darkGray
            indicatorView.backgroundColor = isSelected ? UIColor(red: 232.0/255.0, green: 18.0/255.0, blue: 68.0/255.0, alpha: 1.0) : UIColor.white
        }
    }
    
}
