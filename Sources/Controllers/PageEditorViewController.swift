//
//  PageEditorViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class PageEditorViewController: BaseViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var EditMenuCollectionView: UICollectionView!
    @IBOutlet weak var editorView: UIView!
    @IBOutlet var EditorViewAspectRatioConstraints: [NSLayoutConstraint]!
    
    // MARK: - Method
    
    func configureUI() {
        self.EditMenuCollectionView.register(UINib(nibName: EditMenuCollectionViewCell.toString, bundle: nil), forCellWithReuseIdentifier: EditMenuCollectionViewCell.toString)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //메모리 문제 가능성 보임
        // Dispose of any resources that can be recreated.
    }
}

extension PageEditorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditMenuCollectionViewCell.toString, for: indexPath) as! EditMenuCollectionViewCell
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
}
