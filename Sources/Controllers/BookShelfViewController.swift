//
//  BookShelfViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Toaster

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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        collectionView.reloadData()
    }
}

extension BookShelfViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - CollectionView DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let ret = webToons?.count ?? 0
        if ret == 0 { collectionView.isHidden = true }
        else { collectionView.isHidden = false }
        return ret
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookShelfCollectionViewCell.toString, for: indexPath) as! BookShelfCollectionViewCell
        cell.set(model: webToons![indexPath.row])
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! BookShelfCollectionViewCell
        let menus = ["뷰어로 읽기", "이어서 편집", "갤러리에 저장", "삭제"]
        let _ = ListPopoverViewController.make(source: menus).then {
            $0.modalPresentationStyle = .popover
            $0.delegate = self
            $0.popoverPresentationController?.delegate = self
            $0.popoverPresentationController?.backgroundColor = .white
            $0.popoverPresentationController?.sourceRect = cell.bounds
            $0.popoverPresentationController?.sourceView = cell
            $0.data = cell.model
            $0.preferredContentSize = CGSize(width: 103, height: $0.rowHeight * CGFloat(menus.count))
            present($0, animated: true, completion: nil)
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

extension BookShelfViewController: TMPopoverDelegate {
    func popover(_ controller: BasePopoverViewController, didSelectIndex index: Int) {
        guard let model = controller.data as? WebToon else { controller.dismiss(animated: true, completion: nil); return }
        controller.dismiss(animated: true, completion: {
            if index == 0 {
                //뷰어로 읽기
                if let _ = model.pages[0].image {
                    let viewerVC = ViewerViewController.make()
                    viewerVC.model = model
                    self.navigationController?.pushViewController(viewerVC, animated: true)
                }else {
                    Toast(text: "이미지가 없습니다. '이어서 편집' 기능으로 웹툰을 채워주세요.").show()
                }
            }else if index == 1 {
                //이어서 편집
                let toonMakerVC = ToonMakerViewController.make()
                toonMakerVC.webToonModel = model
                self.navigationController?.pushViewController(toonMakerVC, animated: true)
            }else if index == 2 {
                
            }else if index == 3 {
                //삭제
                let alert = UIAlertController(title: "삭제", message: "삭제 실행 이후 다시 되돌릴 수 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                    if WebToonStore.shared.remove(webToon: model) {
                        Toast(text: "삭제 되었습니다.").show()
                        self.fetchData()
                        self.collectionView.reloadData()
                    }else {
                        Toast(text: "삭제에 실패했습니다.").show()
                    }
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

extension BookShelfViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = .any
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

