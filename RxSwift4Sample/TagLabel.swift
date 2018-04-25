//
//  TagLabel.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/25.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

class TagLabel: UILabel {

    let tagPadding: CGFloat = 5

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        textColor = UIColor.black
        clipsToBounds = true
        numberOfLines = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: tagPadding, left: tagPadding, bottom: tagPadding, right: tagPadding)
        return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
