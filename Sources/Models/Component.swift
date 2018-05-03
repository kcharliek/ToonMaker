//
//  Component.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class Component: UIView {
    var movable: Bool = false
    var scale: CGFloat?
    var xPercentage: CGFloat?
    var yPercentage: CGFloat?
}

class Sticker: Component {
    var image: UIImage?
}

class TextBubble: Component {
    var image: UIImage?
    var text: String?
}
