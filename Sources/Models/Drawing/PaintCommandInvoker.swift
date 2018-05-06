//
//  PaintInvoker.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class PaintCommandInvoker {
    private var commands = [PaintCommand]()
 
    func addCommand(cmd: PaintCommand) {
        commands.append(cmd)
    }
    
    func doCommand() {
 
    }
 
    func undoCommand() {
 
    }
 }
