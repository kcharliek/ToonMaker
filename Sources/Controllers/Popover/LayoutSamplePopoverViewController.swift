//
//  LayoutSamplePopoverViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 9..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class LayoutSamplePopoverViewController: BasePopoverViewController {
    let layouts: [ToonLayout] = ToonLayout.getAll()
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Method
    func configureUI() {
        collectionView.register(UINib(nibName: LayoutSampleCollectionViewCell.toString, bundle: nil), forCellWithReuseIdentifier: LayoutSampleCollectionViewCell.toString)
    }
    
    static func make() -> LayoutSamplePopoverViewController {
        let vc = Storyboard.popover.instantiateViewController(withIdentifier: "LayoutSamplePopoverViewController") as! LayoutSamplePopoverViewController
        return vc
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}



extension LayoutSamplePopoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LayoutSampleCollectionViewCell.toString, for: indexPath) as! LayoutSampleCollectionViewCell
        cell.set(image: layouts[indexPath.row].sample)
        return cell
    }
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.popover!(self, didSelectLayout: layouts[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
