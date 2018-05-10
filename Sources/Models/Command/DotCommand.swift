//
//  PaintCommand.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit


class DotCommand: NSObject, NSCoding, PaintCommand {
    // MARK: - Variable
    var current: Dot!
    var previous: Dot?
    var width: CGFloat = 5
    var color: Color = .black
    
    // MARK: - Command Protocol
    func execute(in canvas: Canvas) {
        configure(canvas: canvas)
        
        if let previous = previous {
            let previousCenter = previous.center
            let currentCenter = current.center
            
            canvas.context.move(to: CGPoint(x: previousCenter.x, y: previousCenter.y))
            canvas.context.addLine(to: CGPoint(x: currentCenter.x, y: currentCenter.y))
        }else {
            canvas.context.move(to: CGPoint(x: current.a.x, y: current.a.y))
            canvas.context.addLine(to: CGPoint(x: current.b.x, y: current.b.y))
        }
        canvas.context.strokePath()
    }
    
    // MARK: - Method
    init(current: Dot!, previous: Dot?) {
        self.current = current
        self.previous = previous
        self.width = current.width
        self.color = current.color
    }
    
    
    
    private func configure(canvas: Canvas) {
        canvas.context.setStrokeColor(color.cgColor)
        canvas.context.setLineWidth(width)
        canvas.context.setLineCap(CGLineCap.round)
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(current, forKey: "current")
        aCoder.encode(previous, forKey: "previous")
        aCoder.encode(width, forKey: "width")
        aCoder.encode(color, forKey: "color")
    }
    
    required init(coder aDecoder: NSCoder) {
        current = aDecoder.decodeObject(forKey: "current") as! Dot
        previous = aDecoder.decodeObject(forKey: "previous") as? Dot
        width = aDecoder.decodeObject(forKey: "width") as! CGFloat
        color = aDecoder.decodeObject(forKey: "color") as! Color
    }
}
