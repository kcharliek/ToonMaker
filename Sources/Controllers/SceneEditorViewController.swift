//
//  PageEditorViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 3..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit
import Then

class SceneEditorViewController: BaseViewController {
    let menus: [(Menu, UIImage)] = [(.save,#imageLiteral(resourceName: "editor_menu_save")), (.color,#imageLiteral(resourceName: "editor_menu_color")), (.grab, #imageLiteral(resourceName: "editor_menu_grab")), (.pen, #imageLiteral(resourceName: "editor_menu_pen")), (.eraser, #imageLiteral(resourceName: "editor_menu_eraser")), (.sticker, #imageLiteral(resourceName: "editor_menu_sticker")), (.bubble, #imageLiteral(resourceName: "editor_menu_bubble")),(.undo,#imageLiteral(resourceName: "editor_menu_undo")),(.redo,#imageLiteral(resourceName: "editor_menu_redo")), (.clear, #imageLiteral(resourceName: "editor_menu_clear"))]
    
    // MARK: - IBOutlet
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var editorView: PaintView!
    
    // MARK: - Variable
    var model: WebToonScene?
    var isLandscape: Bool = false
    var mode: Menu = .grab
    var config: EditorConfiguration! = EditorConfiguration()
    
    //Temporary Variables For Drawing Line
    var lastPoint: CGPoint = CGPoint.zero
    var lineCommand: LineCommand?
    var lastDot: Dot?
    
    // MARK: - Actions
    @IBAction func backBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: sender.view)
        switch sender.state {
        case .began:
            panBeganAt(point: point)
        case .changed:
            panChangedAt(point: point)
        case .ended, .cancelled, .failed:
            panEndAt(point: point)
        default:
            break
        }
    }
    
    func undo() {
        editorView.reset()
        editorView.execute(commands: config.commandInvoker.undoCommands())
    }
    
    func redo() {
        editorView.reset()
        editorView.execute(commands: config.commandInvoker.redoCommands())
    }
    
    // MARK: - Method
    func panBeganAt(point: CGPoint) {
        if mode == .pen || mode == .eraser {
            lineCommand = LineCommand()
        }
        lastPoint = point
    }
    
    func panChangedAt(point: CGPoint) {
        if mode == .pen || mode == .eraser {
            let width: CGFloat = mode == .pen ? config.penWidth : config.eraserWidth
            let color: Color = mode == .eraser ? .white : config.currentColor
            let dot = Dot(a: lastPoint, b: point, width: width, color: color)
            
            let dotCommand = DotCommand(current: dot, previous: lastDot)
            editorView.execute(commands: [dotCommand])
            lineCommand?.addDotCommand(command: dotCommand)
            lastDot = dot
        }
        
        lastPoint = point
    }
    
    func panEndAt(point: CGPoint) {
        if mode == .pen || mode == .eraser {
            if let lineCommand = lineCommand {
                config.commandInvoker.add(command: lineCommand)
            }
            lastDot = nil
            lineCommand = nil
        }
        
        lastPoint = CGPoint.zero
    }
    
    func clearScene() {
        let alert = UIAlertController(title: "화면 비우기", message: "화면 내 모든 내용이 사라집니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { (_) in
            self.config.commandInvoker.removeAllCommands()
            self.editorView.reset()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(okAction); alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    public static func make(model: WebToonScene?) -> SceneEditorViewController {
        let vc = Storyboard.main.instantiateViewController(withIdentifier: "SceneEditorViewController") as! SceneEditorViewController
        vc.model = model
        return vc
    }
    
    func configureUI() {
        view.do {
            $0.backgroundColor = TMColor.primaryColor
        }
        menuCollectionView.do {
            $0.register(UINib(nibName: EditorMenuCollectionViewCell.toString, bundle: nil), forCellWithReuseIdentifier: EditorMenuCollectionViewCell.toString)
            $0.backgroundColor = TMColor.primaryColor
        }

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
                
        configureFor(orientation: UIDevice.current.orientation)
    }
    
    func configureFor(orientation: UIDeviceOrientation) {
        if orientation.isLandscape {
            if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .vertical
            }
            isLandscape = true
        }else {
            if let flowLayout = menuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.scrollDirection = .horizontal
            }
            isLandscape = false
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
        
        if (model?.layout?.aspectRatio)! < 1 {
            AppUtility.lockOrientation(.landscape, andRotateTo: .landscapeRight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //메모리 문제 가능성 보임
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        configureFor(orientation: UIDevice.current.orientation)
    }
}

extension SceneEditorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditorMenuCollectionViewCell.toString, for: indexPath) as! EditorMenuCollectionViewCell
        cell.type = menus[indexPath.row].0
        
        var menuImage = menus[indexPath.row].1
        if cell.type == .color, let tintedImage = menuImage.tinted(with: config.currentColor) {
            menuImage = tintedImage
        }
        cell.setIcon(image: menuImage)
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! EditorMenuCollectionViewCell
            if cell.type == .color {
                let _ = EditorMenuColorPopoverViewController.make().then {
                    $0.modalPresentationStyle = .popover
                    $0.delegate = self
                    $0.popoverPresentationController?.delegate = self
                    $0.popoverPresentationController?.backgroundColor = .white
                    $0.popoverPresentationController?.sourceRect = cell.bounds
                    $0.popoverPresentationController?.sourceView = cell
                    let width: CGFloat = 200
                    $0.preferredContentSize = CGSize(width: width, height: width * 1.5)
                    present($0, animated: true, completion: nil)
                }
            }else if cell.type == .pen || cell.type == .eraser {
                let _ = EditorMenuDrawWidthPopoverViewController.make().then {
                    $0.modalPresentationStyle = .popover
                    $0.delegate = self
                    $0.popoverPresentationController?.delegate = self
                    $0.popoverPresentationController?.backgroundColor = .white
                    $0.popoverPresentationController?.sourceRect = cell.bounds
                    $0.popoverPresentationController?.sourceView = cell
                    $0.type = cell.type
                    $0.dotWidth = cell.type == .pen ? config.penWidth : config.eraserWidth
                    $0.preferredContentSize = CGSize(width: 300, height: 125)
                    present($0, animated: true, completion: nil)
                }
            }else if cell.type == .undo { undo() }
            else if cell.type == .redo { redo() }
            else if cell.type == .clear { clearScene() }
            
            mode = cell.type
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 17
    }
}

extension SceneEditorViewController: TMPopoverDelegate {
    func popover(_ controller: BasePopoverViewController, didSelectColor color: UIColor) {
        config.currentColor = color
        let indexPath = IndexPath(item: 1, section: 0) //color cell
        menuCollectionView.reloadItems(at: [indexPath])
    }
    
    func popover(_ controller: BasePopoverViewController, didSelectValue value: CGFloat) {
        if let vc = controller as? EditorMenuDrawWidthPopoverViewController {
            if vc.type == .pen { config.penWidth = value }
            else { config.eraserWidth = value }
        }
    }
}

extension SceneEditorViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer is UIPanGestureRecognizer {
//            if mode == .pen || mode == .eraser || mode == .grab {
//                return true
//            }
//        }
        return true
    }
}

extension SceneEditorViewController: UIPopoverPresentationControllerDelegate {
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = isLandscape ? .right : .down
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
