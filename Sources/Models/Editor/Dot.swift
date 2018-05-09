//
//  Dot.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 8..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class Dot: NSObject, NSCoding {
    // MARK: - Variable
    var a: CGPoint! //좌 상단 위치
    var b: CGPoint! //우 하단 위치
    var width: CGFloat!
    var color: Color!
    
    var center: CGPoint {
        return CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }
    
    // MARK: - Method
    init(a: CGPoint, b: CGPoint, width: CGFloat, color: Color = .black) {
        self.a = a
        self.b = b
        self.width = width
        self.color = color
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(a, forKey: "a")
        aCoder.encode(b, forKey: "b")
        aCoder.encode(width, forKey: "width")
        aCoder.encode(color, forKey: "color")
    }
    
    required init(coder aDecoder: NSCoder) {
        a = aDecoder.decodeObject(forKey: "a") as! CGPoint
        b = aDecoder.decodeObject(forKey: "b") as! CGPoint
        width = aDecoder.decodeObject(forKey: "width") as! CGFloat
        color = aDecoder.decodeObject(forKey: "color") as! Color
    }
}
