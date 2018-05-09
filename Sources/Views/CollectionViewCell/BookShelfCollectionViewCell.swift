//
//  BookShelfCollectionViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class BookShelfCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var model: WebToon?
    
    func set(model: WebToon) {
        coverImageView.image = model.pages[0].image ?? #imageLiteral(resourceName: "etc_noImage")
        titleLabel.text = model.title
        self.model = model
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = Color.black.cgColor
        layer.borderWidth = 1
    }
    
    static var toString: String {
        return "BookShelfCollectionViewCell"
    }
}
