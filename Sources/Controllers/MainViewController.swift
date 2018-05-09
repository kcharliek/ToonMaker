//
//  MainViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 2..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Toaster

class MainViewController: BaseViewController {

    
    @IBAction func bookShelfBtnClicked(_ sender: Any) {
        let nav = BaseNavigationController()
        let bookShelfVC = BookShelfViewController.make()
        nav.viewControllers = [bookShelfVC]
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func newToonBtnClicked(_ sender: Any) {
        let alert = UIAlertController(title: "새 웹툰 만들기", message: "제목을 입력해 주세요", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "웹툰 제목"
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            let nav = BaseNavigationController()
            let toonMakerVC = ToonMakerViewController.make()
            
            let titleText = alert.textFields![0].text
            let newWebToon = WebToon(title: titleText)
            
            if WebToonStore.shared.save(webToon: newWebToon) {
                toonMakerVC.webToonModel = newWebToon
                nav.viewControllers = [toonMakerVC]
                self.present(nav, animated: true, completion: nil)
            }else {
                Toast(text: "데이터를 저장하지 못했습니다.").show()
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
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
