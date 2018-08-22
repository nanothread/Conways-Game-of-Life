//
//  OptionCell.swift
//  Conway's Game of Life
//
//  Created by Andrew Glen on 22/08/2018.
//  Copyright © 2018 LivePerson. All rights reserved.
//

import UIKit

class OptionCell: UICollectionViewCell {
    static let estimatedSize = CGSize(width: 80, height: 100)
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var iconBackgroundView: UIView!
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconBackgroundView.layer.cornerRadius = 25
    }
    
    func configure(with option: MenuOption) {
        iconImageView.image = option.icon
        iconBackgroundView.backgroundColor = option.color
        label.text = option.name
    }
}
