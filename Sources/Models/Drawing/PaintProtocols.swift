//
//  CommandProtocols.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

protocol PaintCommand { }
extension PaintCommand {
    //For Optional Implementation
    func add(in canvas: Canvas ){ }
    func draw(in canvas: Canvas){ }
}

protocol Canvas {
    var context: CGContext { get }
    var view: UIView { get }
}

