//
//  ToonMakerViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Then
import SnapKit
import Actions
import DropDown

class ToonMakerViewController: BaseViewController {
    @IBOutlet weak var toonPageView: UIView!
    
    @IBOutlet weak var moreBarButtonItem: UIBarButtonItem!
    
    var webToonModel: WebToon?
    var currentPage: Int = -1
//    {
//        didSet {
//            if currentPage > 0 {
//                pageModel = webToonModel?.pages[]
//            }
//        }
//    }
    var dropDown: DropDown!
    var pageModel: WebToonPage? {
        didSet {
            drawScenes()
        }
    }
    var isNewBook: Bool = false
    let sceneSpacing: CGFloat = 5
    
    // MARK: - Actions
    
    @IBAction func moreBtnClicked(_ sender: UIButton) {
        let menus = ["템플릿 변경", "책 설정", "페이지 설정"]
        let _ = PopoverListViewController.make(source: menus).then {
            $0.modalPresentationStyle = .popover
            $0.popoverPresentationController?.delegate = self
            $0.popoverPresentationController?.backgroundColor = .white
            $0.rowHeight = 35
            $0.preferredContentSize = CGSize(width: 100, height: $0.rowHeight * CGFloat(menus.count))
            present($0, animated: true, completion: nil)
        }
    }
    
    @IBAction func viewSwiped(_ sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        if sender.direction == .up {
            go(page: currentPage - 1)
        }else if sender.direction == .down {
            go(page: currentPage - 1)
        }
    }
    
    @IBAction func goBeforePageBtnClicked(_ sender: Any) {
        go(page: currentPage - 1)
    }
    @IBAction func goNextPageBtnClicked(_ sender: Any) {
        go(page: currentPage + 1)
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sceneSelected(sender: Any) {
        let sender = sender as! UIImageView
        let selectedScene = pageModel?.scenes?[sender.tag]
        let editorVC = PageEditorViewController.make(model: selectedScene)
        navigationController?.pushViewController(editorVC, animated: true)
    }
    // MARK: - Method
    
    func go(page: Int) {
        
    }
    
    private func drawScenes() {
        guard let toonLayout = pageModel?.layout else { return }
        
        var idx = 0
        for sceneLayout in toonLayout.sceneLayouts {
            toonPageView.layoutIfNeeded()
            let sceneFrame = sceneLayout.frame(in: toonPageView.bounds)
            let _ = UIImageView().then {
                $0.frame = sceneFrame.insetBy(dx: sceneSpacing, dy: sceneSpacing)
                $0.layer.borderColor = Color.black.cgColor
                $0.layer.borderWidth = 1
                $0.tag = idx
                $0.addTap(action: {self.sceneSelected(sender: $0)})
                toonPageView.addSubview($0)
            }
            idx = idx + 1
        }
    }
    
    public static func make() -> ToonMakerViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "ToonMakerViewController") as! ToonMakerViewController
    }
    
    func makeNewBook() {
        let newWebToon = WebToon()
        let newPage = WebToonPage()
        newPage.layout = ToonLayout.Type5()
        newWebToon.pages.append(newPage)
        
        webToonModel = newWebToon
        pageModel = newPage
    }
    
    func configureUI() {
        dropDown = DropDown().then {
            $0.anchorView = moreBarButtonItem
            $0.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
            }
            $0.dataSource = ["삭제"]
        }
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isNewBook {
            makeNewBook()
        }
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension ToonMakerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ToonMakerViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = .any
        popoverPresentationController.barButtonItem = moreBarButtonItem
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
