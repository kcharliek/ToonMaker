//
//  BookShelfViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class BookShelfViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    let sectionInsetValue: CGFloat = 20
    let itemSpcing: CGFloat = 20
    // MARK: - Variable
    var webToons: [WebToon]?
    
    @IBAction func closeBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Method
    func fetchData() {
        webToons = WebToonStore.shared.fetchAllWebToons()
    }
    
    static func make() -> BookShelfViewController {
        let vc = Storyboard.main.instantiateViewController(withIdentifier: "BookShelfViewController") as! BookShelfViewController
        return vc
    }
    
    func configureUI() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: sectionInsetValue, left: sectionInsetValue, bottom: sectionInsetValue, right: sectionInsetValue)
        }
        
        
        collectionView.register(UINib(nibName: BookShelfCollectionViewCell.toString, bundle: nil), forCellWithReuseIdentifier: BookShelfCollectionViewCell.toString)
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchData()
    }
}

extension BookShelfViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return webToons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookShelfCollectionViewCell.toString, for: indexPath) as! BookShelfCollectionViewCell
        cell.set(model: webToons![indexPath.row])
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BookShelfCollectionViewCell
        if let model = cell.model, let _ = model.pages[0].image {
            let viewerVC = ViewerViewController.make()
            navigationController?.pushViewController(viewerVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - sectionInsetValue * 2 - itemSpcing) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpcing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpcing
    }
    
}
