//
//  MainViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 2..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    // MARK: - Method
    public func make() -> MainViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
