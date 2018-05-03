//
//  ToonLayout.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

struct SceneLayout {
    private var startPoint: (Int, Int) //Horizontal Position : 0, 1, Vertical Position : 0, 1, 2
//    var endPoint: (Int, Int)
    private var widthRatio: CGFloat
    private var heightRatio: CGFloat
    
    init(sp: (Int, Int), wr: CGFloat, hr: CGFloat) {
        startPoint = sp
        widthRatio = wr
        heightRatio = hr
    }
    
    func frame(in superViewFrame: CGRect) ->CGRect {
        let x = superViewFrame.width * CGFloat(startPoint.0 / 2)
        let y = superViewFrame.height * CGFloat(startPoint.1 / 3)
        let width = superViewFrame.width * widthRatio
        let height = superViewFrame.height * heightRatio
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
}

class ToonLayout: NSObject {
    var scenes = [SceneLayout]()
    var numberOfSecenes: Int = 0
    
    static func getAll() -> [ToonLayout] {
        return [Type1(), Type2(), Type3(), Type4()]
    }
    
    static func Type1() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: 1)
        layout.scenes.append(scene1)
        
        layout.numberOfSecenes = layout.scenes.count
        
        return layout
    }
    
    static func Type2() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: CGFloat(2/3))
        let scene2 = SceneLayout(sp: (0,2), wr: 1, hr: CGFloat(1/3))
        
        layout.scenes.append(scene1)
        layout.scenes.append(scene2)
        layout.numberOfSecenes = layout.scenes.count
        
        return layout
    }
    
    static func Type3() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: CGFloat(1/3))
        let scene2 = SceneLayout(sp: (0,2), wr: 1, hr: CGFloat(2/3))
        
        layout.scenes.append(scene1)
        layout.scenes.append(scene2)
        layout.numberOfSecenes = layout.scenes.count
        
        return layout
    }

    
    static func Type4() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: CGFloat(1/3))
        let scene2 = SceneLayout(sp: (0,1), wr: 1, hr: CGFloat(1/3))
        let scene3 = SceneLayout(sp: (0,2), wr: 1, hr: CGFloat(1/3))
        
        layout.scenes.append(scene1)
        layout.scenes.append(scene2)
        layout.scenes.append(scene3)
        layout.numberOfSecenes = layout.scenes.count
        
        return layout
    }
    
    
}
