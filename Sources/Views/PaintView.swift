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
    
    // MARK: - Variable
    private var buffer: UIImage?
    
    // MARK: - Method
    func reset() {
        buffer = nil
        layer.contents = nil
    }
    
    func execute(commands: [PaintCommand]?) {
        guard let commands = commands else { return }
        
        buffer = drawView(fire: {
            for cmd in commands { cmd.execute(in: self) }
        })
        
        layer.contents = buffer?.cgImage ?? nil
    }
    
    private func drawView(fire :() -> Void) -> UIImage? {
        let size = bounds.size
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
//        let context = UIGraphicsGetCurrentContext()
        let context = self.context
        context.setFillColor(Color.white.cgColor)
        context.fill(bounds)
        
        if let buffer = buffer {
            buffer.draw(in: bounds)
        }
        
        fire()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
