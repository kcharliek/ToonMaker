//
//  EditorConfig.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 8..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class EditorConfiguration {
    var penWidth: CGFloat = 5.0
    var eraserWidth: CGFloat = 7.0
    var currentColor: Color = .black
    var canUndo: Bool = false
    var canRedo: Bool = false
    
    var commandInvoker: PaintCommandInvoker!
    
    init() {
        commandInvoker = PaintCommandInvoker()
    }
}
