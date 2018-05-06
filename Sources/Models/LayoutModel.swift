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
    private var widthRatio: CGFloat
    private var heightRatio: CGFloat
    public var aspectRatio: CGFloat
    
    init(sp: (Int, Int), wr: CGFloat, hr: CGFloat) {
        startPoint = sp
        widthRatio = wr / 2
        heightRatio = hr / 3
        aspectRatio = hr / wr
    }
    
    func frame(in superViewFrame: CGRect) ->CGRect {
        let x = superViewFrame.width * CGFloat(startPoint.0) / 2
        let y = superViewFrame.height * CGFloat(startPoint.1) / 3
        let width = superViewFrame.width * widthRatio
        let height = superViewFrame.height * heightRatio
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}

class ToonLayout: NSObject {
    var sceneLayouts = [SceneLayout]()
    var numberOfSecenes: Int = 0
    
    static func getAll() -> [ToonLayout] {
        return [Type1(), Type2(), Type3(), Type4()]
    }
    
    static func Type1() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 3)
        layout.sceneLayouts.append(scene1)
        
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type2() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 2)
        let scene2 = SceneLayout(sp: (0,2), wr: 2, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type3() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 1)
        let scene2 = SceneLayout(sp: (0,1), wr: 2, hr: 2)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }

    
    static func Type4() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 1)
        let scene2 = SceneLayout(sp: (0,1), wr: 2, hr: 1)
        let scene3 = SceneLayout(sp: (0,2), wr: 2, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.sceneLayouts.append(scene3)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type5() -> ToonLayout {
        let layout = ToonLayout()
        
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: 2)
        let scene2 = SceneLayout(sp: (1,0), wr: 1, hr: 1)
        let scene3 = SceneLayout(sp: (0,2), wr: 1, hr: 1)
        let scene4 = SceneLayout(sp: (1,1), wr: 1, hr: 2)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.sceneLayouts.append(scene3)
        layout.sceneLayouts.append(scene4)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
}
