//
//  LineCommand.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 7..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class LineCommand: PaintCommand {
    private var dotCommands = [DotCommand]()
    
    
    func execute(in canvas: Canvas) {
        for dotCmd in dotCommands {
            dotCmd.execute(in: canvas)
        }
    }
    
    func addDotCommand(command: DotCommand) {
        dotCommands.append(command)
    }
}
