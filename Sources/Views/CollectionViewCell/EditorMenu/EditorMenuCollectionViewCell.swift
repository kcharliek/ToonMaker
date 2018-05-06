//
//  EditorMenuCollectionViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class EditorMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    var type: Menu!
    
    func setIcon(image: UIImage) {
        iconImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = TMColor.primaryColor
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = Color.white.cgColor
                layer.borderWidth = 1
            }else {
                layer.borderWidth = 0
            }
        }
    }
    
    static var toString: String {
        return "EditorMenuCollectionViewCell"
    }
}
