//
//  EditorMenuColorCollectionViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class EditorMenuColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var checkImageView: UIImageView!
    
    var color: Color? {
        didSet {
            contentView.backgroundColor = color
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkImageView.isHidden = false
            }else {
                checkImageView.isHidden = true
            }
        }
    }
    
    static var toString: String {
        return "EditorMenuColorCollectionViewCell"
    }
}
