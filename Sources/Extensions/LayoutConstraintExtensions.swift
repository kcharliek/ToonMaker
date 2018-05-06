//
//  LayoutConstraintExtensions.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 5..
//  Copyright © 2018년 CHK. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat?) -> NSLayoutConstraint? {
        guard let firstItem = self.firstItem, let multiplier = multiplier else { return nil }
        return NSLayoutConstraint(item: firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
