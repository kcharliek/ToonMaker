//
//  PaintInvoker.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class PaintCommandInvoker: NSObject, NSCoding {
    // MARK: - Variable
    private var commands = [PaintCommand]()
    private var itr: Int = -1
    
    // MARK: - Method
    override init() {
        super.init()
    }
    
    func add(command: PaintCommand) {
        if itr >= 0 { commands = Array(commands[0...itr]) }
        else { commands.removeAll() }
        
        commands.append(command)
        itr = commands.count - 1
    }
    
    func removeAllCommands() {
        commands.removeAll()
        itr = -1
    }
    
    func redoCommands() -> [PaintCommand]? {
        guard itr < commands.count - 1 else { return commands }
        
        itr = itr + 1
        return Array(commands[0...itr])
    }
    
    func undoCommands() -> [PaintCommand]? {
        guard itr > 0 else { itr = -1; return nil }
        
        itr = itr - 1
        return Array(commands[0...itr])
    }
    
    func currentCommands() -> [PaintCommand]? {
        guard itr >= 0 else { return nil }
        return Array(commands[0...itr])
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(commands, forKey: "commands")
        aCoder.encode(itr, forKey: "itr")
    }
    
    required init(coder aDecoder: NSCoder) {
        commands = aDecoder.decodeObject(forKey: "commands") as! [PaintCommand]
        itr = aDecoder.decodeInteger(forKey: "itr")
    }
 }
