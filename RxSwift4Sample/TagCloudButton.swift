//
//  TagCloudButton.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/26.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

extension UIImage {
    /// UIColorをUIImageに
    static func createImageFromUIColor(_ color: UIColor) -> UIImage {
        // 1x1のbitmapを作成
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        // bitmapを塗りつぶし
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        // UIImageに変換
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

class TagCloudButton: UIButton {

    let tagPadding: CGFloat = 5

    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setBackgroundImage(UIImage.createImageFromUIColor(.gray), for: .normal)
            } else {
                self.setBackgroundImage(UIImage.createImageFromUIColor(.white), for: .normal)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0
        self.titleLabel!.font = UIFont(name: "HiraKakuProN-W3", size: 16)
        self.setTitleColor(UIColor.black, for: .normal)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }

    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }

}
