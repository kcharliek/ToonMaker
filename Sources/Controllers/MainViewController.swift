//
//  MainViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 2..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    
    @IBAction func bookShelfBtnClicked(_ sender: Any) {
        
    }
    
    @IBAction func newToonBtnClicked(_ sender: Any) {
        let nav = UINavigationController()
        let toonMakerVC = ToonMakerViewController.make()
        toonMakerVC.isNewBook = true
        nav.viewControllers = [toonMakerVC]
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Method
    public func make() -> MainViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
