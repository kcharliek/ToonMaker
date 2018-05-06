//
//  PaintView.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class PaintView: UIView, Canvas {
    
    // MARK: - Canvase Protocol Implementation
    
    var context: CGContext {
        return UIGraphicsGetCurrentContext()!
    }
    var contentView: UIView {
        return self
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
