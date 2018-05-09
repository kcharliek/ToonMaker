//
//  ToonLayout.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class SceneLayout: NSObject, NSCoding {
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
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(startPoint.0, forKey: "startPoint0")
        aCoder.encode(startPoint.1, forKey: "startPoint1")
        aCoder.encode(widthRatio, forKey: "widthRatio")
        aCoder.encode(heightRatio, forKey: "heightRatio")
        aCoder.encode(aspectRatio, forKey: "aspectRatio")
    }
    
    required init(coder aDecoder: NSCoder) {
        let startPoint0 = aDecoder.decodeInteger(forKey: "startPoint0")
        let startPoint1 = aDecoder.decodeInteger(forKey: "startPoint1")
        startPoint = (startPoint0, startPoint1)
        widthRatio = aDecoder.decodeObject(forKey: "widthRatio") as! CGFloat
        heightRatio = aDecoder.decodeObject(forKey: "heightRatio") as! CGFloat
        aspectRatio = aDecoder.decodeObject(forKey: "aspectRatio") as! CGFloat
    }
}

class ToonLayout: NSObject, NSCoding {
    var sceneLayouts = [SceneLayout]()
    var numberOfSecenes: Int = 0
    var sample: UIImage!
    
    override init() {
        super.init()
    }
    
    static func getAll() -> [ToonLayout] {
        return [Type1(), Type2(), Type3(), Type4(), Type5(), Type6(), Type7(), Type8()]
    }
    
    static func Type1() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type1")
        
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 3)
        layout.sceneLayouts.append(scene1)
        
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type2() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type2")
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 2)
        let scene2 = SceneLayout(sp: (0,2), wr: 2, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type3() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type3")
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 1)
        let scene2 = SceneLayout(sp: (0,1), wr: 2, hr: 2)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }

    
    static func Type4() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type4")
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
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type5")
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
    
    static func Type6() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type6")
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: 1)
        let scene2 = SceneLayout(sp: (1,0), wr: 1, hr: 2)
        let scene3 = SceneLayout(sp: (0,1), wr: 1, hr: 2)
        let scene4 = SceneLayout(sp: (1,2), wr: 1, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.sceneLayouts.append(scene3)
        layout.sceneLayouts.append(scene4)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type7() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type7")
        let scene1 = SceneLayout(sp: (0,0), wr: 2, hr: 1)
        let scene2 = SceneLayout(sp: (0,1), wr: 1, hr: 1)
        let scene3 = SceneLayout(sp: (1,1), wr: 1, hr: 1)
        let scene4 = SceneLayout(sp: (0,2), wr: 2, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.sceneLayouts.append(scene3)
        layout.sceneLayouts.append(scene4)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    static func Type8() -> ToonLayout {
        let layout = ToonLayout()
        layout.sample = #imageLiteral(resourceName: "Layout_Sample_Type8")
        let scene1 = SceneLayout(sp: (0,0), wr: 1, hr: 1)
        let scene2 = SceneLayout(sp: (1,0), wr: 1, hr: 1)
        let scene3 = SceneLayout(sp: (0,1), wr: 2, hr: 1)
        let scene4 = SceneLayout(sp: (0,2), wr: 1, hr: 1)
        let scene5 = SceneLayout(sp: (1,2), wr: 1, hr: 1)
        
        layout.sceneLayouts.append(scene1)
        layout.sceneLayouts.append(scene2)
        layout.sceneLayouts.append(scene3)
        layout.sceneLayouts.append(scene4)
        layout.sceneLayouts.append(scene5)
        layout.numberOfSecenes = layout.sceneLayouts.count
        
        return layout
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sceneLayouts, forKey: "sceneLayouts")
        aCoder.encode(numberOfSecenes, forKey: "numberOfSecenes")
        aCoder.encode(sample, forKey: "sample")
    }
    
    required init(coder aDecoder: NSCoder) {
        sceneLayouts = aDecoder.decodeObject(forKey: "sceneLayouts") as! [SceneLayout]
        numberOfSecenes = aDecoder.decodeInteger(forKey: "numberOfSecenes")
        sample = aDecoder.decodeObject(forKey: "sample") as! UIImage
    }
}
