//
//  PageEditorViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Then

class PageEditorViewController: BaseViewController {
    let menus: [(String, UIImage)] = [("컬러",#imageLiteral(resourceName: "editor_menu_color")), ("펜", #imageLiteral(resourceName: "editor_menu_pen")), ("스티커", #imageLiteral(resourceName: "editor_menu_sticker")), ("말풍선", #imageLiteral(resourceName: "editor_menu_bubble")),("undo",#imageLiteral(resourceName: "editor_menu_undo")),("redo",#imageLiteral(resourceName: "editor_menu_redo")),("저장",#imageLiteral(resourceName: "editor_menu_save"))]
    
    // MARK: - IBOutlet
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var editorView: UIView!
    
    var model: WebToonScene?
    
    // MARK: - Actions
    
    @IBAction func backBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Method
    
    public static func make(model: WebToonScene?) -> PageEditorViewController {
        let vc = Storyboard.main.instantiateViewController(withIdentifier: "PageEditorViewController") as! PageEditorViewController
        vc.model = model
        return vc
    }
    
    func configureUI() {
        menuCollectionView.register(UINib(nibName: EditMenuCollectionViewCell.toString, bundle: nil), forCellWithReuseIdentifier: EditMenuCollectionViewCell.toString)
        
        configureFor(orientation: UIDevice.current.orientation)

        editorView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.addConstraint(NSLayoutConstraint(item: $0,
                                                        attribute: NSLayoutAttribute.height,
                                                        relatedBy: NSLayoutRelation.equal,
                                                        toItem: $0,
                                                        attribute: NSLayoutAttribute.width,
                                                        multiplier: (model?.layout?.aspectRatio)!,
                                                        constant: 0))
            $0.layer.borderColor = Color.black.cgColor
            $0.layer.borderWidth = 1
            $0.layoutIfNeeded()
        }  
    }
    
    func configureFor(orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
        }else {
            if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //메모리 문제 가능성 보임
        // Dispose of any resources that can be recreated.
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        configureFor(orientation: UIDevice.current.orientation)
    }
}

extension PageEditorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditMenuCollectionViewCell.toString, for: indexPath) as! EditMenuCollectionViewCell
        cell.setIcon(image: menus[indexPath.row].1)
        return cell
    }
    
    // MARK: - CollectionView Delegate
}
