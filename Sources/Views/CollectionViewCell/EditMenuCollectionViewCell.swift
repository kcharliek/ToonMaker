//
//  EditMenuCollectionViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class EditMenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setIcon(image: UIImage) {
        iconImageView.image = image
    }
    
    static var toString: String {
        return "EditMenuCollectionViewCell"
    }
}
