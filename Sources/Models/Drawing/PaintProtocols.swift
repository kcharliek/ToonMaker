//
//  CommandProtocols.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

@objc protocol PaintCommand {
    @objc optional func add(in canvas: Canvas )
    @objc optional func draw(in canvas: Canvas)
}

@objc protocol Canvas {
    var context: CGContext { get }
    var contentView: UIView { get }
}
