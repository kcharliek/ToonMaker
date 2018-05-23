//
//  ViewerTableViewCell.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 9..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class ViewerTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var pageImageView: UIImageView!
    
    // MARK: - Variable
    var model: WebToonPage?
    static var toString: String {
        return "ViewerTableViewCell"
    }
    
    // MARK: - Method
    func set(model: WebToonPage) {
        self.model = model
        pageImageView.image = model.image ?? #imageLiteral(resourceName: "etc_noImage")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
