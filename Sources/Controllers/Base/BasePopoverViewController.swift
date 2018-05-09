//
//  BasePopoverViewController.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 6..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit


@objc protocol TMPopoverDelegate {
    @objc optional func popover(_ controller: BasePopoverViewController, didSelectIndex index: Int)
    @objc optional func popover(_ controller: BasePopoverViewController, didSelectValue value: CGFloat)
    @objc optional func popover(_ controller: BasePopoverViewController, didSelectColor color: UIColor)
    @objc optional func popover(_ controller: BasePopoverViewController, didSelectLayout layout: ToonLayout)
}

class BasePopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
