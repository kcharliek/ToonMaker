//
//  LayoutSampleCollectionViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 9..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class LayoutSampleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sampleImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    
    func set(image: UIImage) {
        sampleImageView.image = image
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static var toString: String {
        return "LayoutSampleCollectionViewCell"
    }
}
