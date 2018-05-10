//
//  File.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 10..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class ImageCommand: NSObject, NSCoding, PaintCommand {
    // MARK: - Variable
    var image: UIImage?
    var position: CGRect?
    
    // MARK: - Command Protocol
    func execute(in canvas: Canvas) {
        guard let image = image, let position = position else { return }
//        canvas.context.draw(cgImage, in: position)
        image.draw(in: position)
    }
    
    // MARK: - Method
    init(image: UIImage, position: CGRect) {
        self.image = image
        self.position = position
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        aCoder.encode(position, forKey: "position")
    }
    
    required init(coder aDecoder: NSCoder) {
        image = aDecoder.decodeObject(forKey: "image") as? UIImage
        position = aDecoder.decodeObject(forKey: "position") as? CGRect
    }
}
