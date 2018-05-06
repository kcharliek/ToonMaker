//
//  WebToonModel.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class WebToon {
    var title: String?
    var author: String?
    var creationDate: Date?
    var modifiedDate: Date?
    
    var pages = [WebToonPage]()
}

class WebToonPage {
    var layout: ToonLayout? {
        didSet {
            guard let layout = layout else { return }
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
}

class WebToonScene {
    var layout: SceneLayout?
    var image: UIImage?
    var components: [Component]?
}
