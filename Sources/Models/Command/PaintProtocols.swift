//
//  CommandProtocols.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

@objc protocol PaintCommand {
    func execute(in canvas: Canvas)
}

@objc protocol Canvas {
    var context: CGContext { get }
    var contentView: UIView { get }
}
