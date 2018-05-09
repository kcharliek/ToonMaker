//
//  WebToonModel.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class WebToon: NSObject, NSCoding {
    var title: String!
    var creationDate: Date!
    var modifiedDate: Date!
    var pages = [WebToonPage]()
    
    override init() {
        super.init()
    }
    
    init(title: String!) {
        self.title = title
        creationDate = Date()
        modifiedDate = Date()
        let firstPage = WebToonPage()
        firstPage.layout = ToonLayout.Type1() //Default Layout
        pages.append(firstPage)
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(creationDate, forKey: "creationDate")
        aCoder.encode(modifiedDate, forKey: "modifiedDate")
        aCoder.encode(pages, forKey: "pages")
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        creationDate = aDecoder.decodeObject(forKey: "creationDate") as! Date
        modifiedDate = aDecoder.decodeObject(forKey: "modifiedDate") as! Date
        pages = aDecoder.decodeObject(forKey: "pages") as! [WebToonPage]
    }
}

class WebToonPage: NSObject, NSCoding {
    var layout: ToonLayout! {
        didSet {
            var newScenes = [WebToonScene]()
            for sceneLayout in layout.sceneLayouts {
                let scene = WebToonScene()
                scene.layout = sceneLayout
                newScenes.append(scene)
            }
            scenes = newScenes
        }
    }
    
    var scenes: [WebToonScene]?
    var image: UIImage?
    
    override init() {
        super.init()
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(scenes, forKey: "scenes")
        aCoder.encode(layout, forKey: "layout")
        aCoder.encode(image, forKey: "image")
    }
    
    required init(coder aDecoder: NSCoder) {
        scenes = aDecoder.decodeObject(forKey: "scenes") as? [WebToonScene]
        layout = aDecoder.decodeObject(forKey: "layout") as? ToonLayout
        image = aDecoder.decodeObject(forKey: "image") as? UIImage
    }
}

class WebToonScene: NSObject, NSCoding {
    var layout: SceneLayout!
    var image: UIImage?
    //var components: [Component]?
    
    override init() {
        super.init()
    }
    
    // MARK: - NSCoding Implementation
    func encode(with aCoder: NSCoder) {
        aCoder.encode(layout, forKey: "layout")
        aCoder.encode(image, forKey: "image")
    }
    
    required init(coder aDecoder: NSCoder) {
        layout = aDecoder.decodeObject(forKey: "layout") as! SceneLayout
        image = aDecoder.decodeObject(forKey: "image") as? UIImage
    }
}
