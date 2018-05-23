//
//  WebToonModel.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class WebToon: NSObject, NSCoding {
    // MARK: - Variable
    public private(set) var title: String!
    public private(set) var pages: [WebToonPage]!
    
    public private(set) var creationDate: Date!
    public var modifiedDate: Date!
    
    // MARK: - Constructor
    private override init() {
        super.init()
    }
    
    public init(title: String!) {
        self.title = title
        
        creationDate = Date()
        modifiedDate = Date()
        
        let cover = WebToonPage()
        pages = [WebToonPage]()
        pages.append(cover)
    }
    
    // MARK: - Method
    public func insertNewPage(at: Int) {
        let newPage = WebToonPage()
        pages.insert(newPage, at: at)
    }
    
    public func removePage(at: Int) {
        pages.remove(at: at)
    }
    
    // MARK: - NSCoding Protocol
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
    // MARK: - Variable
    private var scenes: [WebToonScene]!
    public var image: UIImage?
    public private(set) var layout: ToonLayout!
    
    // MARK: - Method
    private override init() {
        super.init()
    }
    
    init(layout: ToonLayout = ToonLayout.Type1()) {
        super.init()
        self.set(layout: layout)
    }
    
    public func scene(index: Int) -> WebToonScene? {
        guard index < scenes.count else { return nil }
        return self.scenes[index]
    }
    
    public func set(layout: ToonLayout) {
        self.layout = layout
        
        var newScenes = [WebToonScene]()
        for sceneLayout in layout.sceneLayouts {
            let scene = WebToonScene(layout: sceneLayout)
            newScenes.append(scene)
        }
        scenes = newScenes
    }
    
    // MARK: - NSCoding Protocol
    func encode(with aCoder: NSCoder) {
        aCoder.encode(scenes, forKey: "scenes")
        aCoder.encode(layout, forKey: "layout")
        aCoder.encode(image, forKey: "image")
    }
    
    required init(coder aDecoder: NSCoder) {
        scenes = aDecoder.decodeObject(forKey: "scenes") as! [WebToonScene]
        layout = aDecoder.decodeObject(forKey: "layout") as! ToonLayout
        image = aDecoder.decodeObject(forKey: "image") as? UIImage
    }
}

class WebToonScene: NSObject, NSCoding {
    // MARK: - Variable
    var layout: SceneLayout!
    var image: UIImage?
    var config: EditorConfiguration!
    
    // MARK: - Constructor
    private override init() {
        super.init()
    }
    
    public init(layout: SceneLayout) {
        self.layout = layout
        config = EditorConfiguration()
    }
    
    // MARK: - NSCoding Protocol
    func encode(with aCoder: NSCoder) {
        aCoder.encode(layout, forKey: "layout")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(config, forKey: "config")
    }
    
    required init(coder aDecoder: NSCoder) {
        layout = aDecoder.decodeObject(forKey: "layout") as! SceneLayout
        image = aDecoder.decodeObject(forKey: "image") as? UIImage
        config = aDecoder.decodeObject(forKey: "config") as! EditorConfiguration
    }
}
