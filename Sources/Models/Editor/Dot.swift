//
//  Dot.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 8..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class Dot {
    var a: CGPoint! //좌 상단 위치
    var b: CGPoint! //우 하단 위치
    var width: CGFloat!
    var color: Color!
    
    var center: CGPoint {
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }
    
    init(a: CGPoint, b: CGPoint, width: CGFloat, color: Color = .black) {
        self.a = a
        self.b = b
        self.width = width
        self.color = color
    }
}
