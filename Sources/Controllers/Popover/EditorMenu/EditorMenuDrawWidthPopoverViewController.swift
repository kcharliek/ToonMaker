//
//  EditorMenuDrawWidthPopoverViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

class EditorMenuDrawWidthPopoverViewController: BasePopoverViewController {
    // MARK: - IBOutlet
    
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var widthSlider: UISlider!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var dotViewWidthConstraint: NSLayoutConstraint!
    
    // MARK: - Variable
    
    var dotWidth: CGFloat?
    var type: Menu!
    // MARK: - Action
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        dotWidth = value
        updateDot(width: value)
    }
    
    // MARK: - Method
    
    func updateDot(width: CGFloat) {
        dotViewWidthConstraint.constant = width
        dotView.layer.cornerRadius = width / 2
        widthLabel.text = String(format: "%.1f", width)
        delegate?.popover!(self, didSelectValue: width)
    }
    
    public static func make() -> EditorMenuDrawWidthPopoverViewController {
        let vc = Storyboard.popover.instantiateViewController(withIdentifier: "EditorMenuDrawWidthPopoverViewController") as! EditorMenuDrawWidthPopoverViewController
        return vc
    }
    
    func configureUI() {
        widthSlider.minimumValue = 0.1
        widthSlider.maximumValue = 50.0
        widthSlider.value = Float(dotWidth ?? 5.0)
        updateDot(width: dotWidth ?? 5)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}
