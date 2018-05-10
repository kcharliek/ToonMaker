//
//  ToonMakerViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Then
import Toaster
import Actions
import PKHUD

class ToonMakerViewController: BaseViewController {
    // MARK: - Constant
    let sceneSpacing: CGFloat = 5
    
    // MARK: - IBOutlet
    @IBOutlet weak var toonPageView: UIView!
    @IBOutlet weak var layoutBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var closeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var newBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var moreBarButtonItem: UIBarButtonItem!
    
    // MARK: - Variable
    private var webToonModel: WebToon!
    private var pageModel: WebToonPage! {
        didSet {
            if isViewDidAppearCalled {
                drawPage()
            }
        }
    }
    private var currentPage: Int = -1 {
        didSet {
            if currentPage >= 0 {
                pageModel = webToonModel?.pages[currentPage]
                if currentPage > 0 {
                    Toast(text: "\(currentPage)/\(webToonModel.pages.count - 1)").show()
                }else {
                    Toast(text: "표지").show()
                }
            }else {
                currentPage = 0
            }
        }
    }
    private var isViewDidAppearCalled: Bool = false
    
    // MARK: - Actions
    @IBAction func newPageBtnClicked(_ sender: Any) {
        var menus = ["아래로 삽입"]
        //cover cannot insert page to front
        if currentPage > 0 { menus.insert("위로 삽입", at: 0) }
        
        let _ = ListPopoverViewController.make(source: menus).then {
            $0.tag = 111
            $0.modalPresentationStyle = .popover
            $0.delegate = self
            $0.popoverPresentationController?.delegate = self
            $0.popoverPresentationController?.backgroundColor = .white
            $0.popoverPresentationController?.barButtonItem = newBarButtonItem
            $0.preferredContentSize = CGSize(width: 95, height: $0.rowHeight * CGFloat(menus.count))
            present($0, animated: true, completion: nil)
        }
    }
    
    @IBAction func moreBtnClicked(_ sender: Any) {
        let menus = ["페이지 삭제"]
        let _ = ListPopoverViewController.make(source: menus).then {
            $0.tag = 222
            $0.modalPresentationStyle = .popover
            $0.delegate = self
            $0.popoverPresentationController?.delegate = self
            $0.popoverPresentationController?.backgroundColor = .white
            $0.popoverPresentationController?.barButtonItem = moreBarButtonItem
            $0.preferredContentSize = CGSize(width: 95, height: $0.rowHeight * CGFloat(menus.count))
            present($0, animated: true, completion: nil)
        }
    }
    
    @IBAction func layoutBtnClicked(_ sender: Any) {
        guard currentPage > 0 else {
            Toast(text: "표지 레이아웃은 변경할 수 없습니다.").show()
            return
        }
        let alert = UIAlertController(title: "레이아웃 변경", message: "레이아웃을 변경하면 페이지 안의 모든 이미지는 삭제됩니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            let _ = LayoutSamplePopoverViewController.make().then {
                $0.modalPresentationStyle = .popover
                $0.delegate = self
                $0.popoverPresentationController?.delegate = self
                $0.popoverPresentationController?.backgroundColor = .white
                $0.popoverPresentationController?.barButtonItem = self.layoutBarButtonItem
                $0.preferredContentSize = CGSize(width: 320, height: 400)
                self.present($0, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func viewSwiped(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            go(page: currentPage + 1)
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
        if navigationController!.viewControllers.count > 1 {
            navigationController!.popViewController(animated: true)
        }else {
            dismiss(animated: true, completion: nil)
        }
        let _ = WebToonStore.shared.save(webToon: webToonModel)
    }
    
    @objc func sceneSelected(sender: Any) {
        let sender = sender as! UIImageView
        guard let scene = pageModel?.scenes?[sender.tag] else { return }
        let editorVC = SceneEditorViewController.make(scene: scene, webtoon: webToonModel)
        navigationController?.pushViewController(editorVC, animated: true)
    }
    
    // MARK: - Method
    func set(model: WebToon) {
        webToonModel = model
        title = model.title
        go(page: 0)
    }
    
    func go(page: Int) {
        if page < 0 {
            Toast(text: "웹툰의 처음입니다.").show()
            return
        }else if page > webToonModel.pages.count - 1 {
            Toast(text: "웹툰의 마지막입니다.").show()
            return
        }
        
        currentPage = page
    }
    
    private func drawPage() {
        guard let toonLayout = pageModel?.layout else { return }
        
        for v in toonPageView.subviews { v.removeFromSuperview() }
        
        var idx = 0
        toonPageView.layoutIfNeeded()
        
        for sceneLayout in toonLayout.sceneLayouts {
            let sceneFrame = sceneLayout.frame(in: toonPageView.bounds)
            let _ = UIImageView().then {
                $0.frame = sceneFrame.insetBy(dx: sceneSpacing, dy: sceneSpacing)
                $0.layer.borderColor = Color.black.cgColor
                $0.layer.borderWidth = 1
                $0.tag = idx
                $0.image = pageModel.scenes[idx].image
                $0.addTap(action: {self.sceneSelected(sender: $0)})
                toonPageView.addSubview($0)
            }
            idx = idx + 1
        }
        toonPageView.backgroundColor = .white
        //make page image
        let image = UIImage(view: toonPageView)
        pageModel.image = image
    }
    
    public static func make() -> ToonMakerViewController {
        return Storyboard.main.instantiateViewController(withIdentifier: "ToonMakerViewController") as! ToonMakerViewController
    }
    
    func configureUI() {
        //pop or dismiss
        closeBarButtonItem.image = navigationController!.viewControllers.count > 1 ? #imageLiteral(resourceName: "etc_arrow_left") : #imageLiteral(resourceName: "etc_close")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HUD.show(.systemActivity)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //start draw after view did appear
        isViewDidAppearCalled = true
        drawPage()
        HUD.hide()
    }
}

extension ToonMakerViewController: TMPopoverDelegate {
    func popover(_ controller: BasePopoverViewController, didSelectIndex index: Int) {
        if controller.tag == 111 {
            //from new page button
            var newPageIndex: Int = 0
            if currentPage > 0 {
                if index == 0 {
                    //insert to front
                    newPageIndex = currentPage
                }else {
                    //insert to back
                    newPageIndex = currentPage + 1
                }
            }else {
                //insert to back
                newPageIndex = currentPage + 1
            }
            webToonModel.insertNewPage(at: newPageIndex)
            go(page: newPageIndex)
            controller.dismiss(animated: true, completion: nil)
            let _ = WebToonStore.shared.save(webToon: self.webToonModel)
        }else if controller.tag == 222 {
            //from more button
            if index == 0 {
                //remove page
                controller.dismiss(animated: true) {
                    guard self.currentPage > 0 else {
                        Toast(text: "표지는 삭제할 수 없습니다.").show()
                        return
                    }
                    let alert = UIAlertController(title: "삭제", message: "삭제 실행 이후 다시 되돌릴 수 없습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                        self.webToonModel.removePage(at: self.currentPage)
                        self.go(page: self.currentPage - 1)
                        let _ = WebToonStore.shared.save(webToon: self.webToonModel)
                    }))
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    func popover(_ controller: BasePopoverViewController, didSelectLayout layout: ToonLayout) {
        pageModel.layout = layout
        drawPage()
        let _ = WebToonStore.shared.save(webToon: webToonModel)
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
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
