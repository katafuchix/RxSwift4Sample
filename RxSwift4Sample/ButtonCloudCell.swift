//
//  ButtonCloudCell.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/26.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

class ButtonCloudCell: UITableViewCell {

    static let titleLabelTopMergin : CGFloat = 10.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// UIのクリア
    func clearViews() {
        for view in self.contentView.subviews {
            if view is TagCloudButton {
                view.removeFromSuperview()
            }
        }
    }

    /// カテゴリボタンの配置 TODO : 数値などを統一する
    func placeTagsOn(tags: [String]) {
        self.clearViews()

        let baseViewFrame = self.frame.insetBy(dx: 20.0, dy: 10.0)
        let areaWidth = baseViewFrame.width + 20
        let tagMargin: CGFloat = 10
        let tagFont = UIFont(name: "HiraKakuProN-W3", size: 16)!
        let tagHeight = tagFont.lineHeight + TagLabel().tagPadding * 2

        var tagOriginX: CGFloat = 28.0
        var tagOriginY: CGFloat = ButtonCloudCell.titleLabelTopMergin + 10.0 //+ 30.0 // borderの下部

        for tag in tags {
            var tagWidth = ButtonCloudCell.tagLabelTextWidth(text: tag, font: tagFont, height: tagHeight)
            if tagWidth > areaWidth {
                tagWidth = areaWidth
            }

            if areaWidth - tagOriginX < tagWidth {
                tagOriginX = 28.0
                tagOriginY += tagHeight + tagMargin
            }

            let button = TagCloudButton(type: .custom)
            button.frame = CGRect(x:tagOriginX, y:tagOriginY, width:tagWidth, height:tagHeight)
            button.setTitle(tag, for: .normal)
            self.contentView.addSubview(button)
            tagOriginX += tagWidth + tagMargin
        }
    }

    // ボタンの幅
    static func tagLabelTextWidth(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x:0, y:0, width:CGFloat.greatestFiniteMagnitude, height:height))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size.width + TagCloudButton().tagPadding * 2
    }

    // border下部 + マージン x2 + 各文字列の高さ + 下部マージン = セルの高さを計算
    // 上のメソッドと処理がかぶるところがあるので改善したい
    static func getCellHeight(width:CGFloat, tags:[String]) -> CGFloat {
        let areaWidth = width - 20
        let tagMargin: CGFloat = 10
        let tagFont = UIFont(name: "HiraKakuProN-W3", size: 16)!
        let tagHeight = tagFont.lineHeight + TagCloudButton().tagPadding * 2

        var tagOriginX: CGFloat = 28
        var tagOriginY: CGFloat = ButtonCloudCell.titleLabelTopMergin + 10.0 //+ 30.0 // borderの下部

        for tag in tags {
            var tagWidth = ButtonCloudCell.tagLabelTextWidth(text: tag, font: tagFont, height: tagHeight)
            if tagWidth > areaWidth {
                tagWidth = areaWidth
            }

            if areaWidth - tagOriginX < tagWidth {
                tagOriginX = 28.0
                tagOriginY += tagHeight + tagMargin
            }

            let label = TagLabel(frame: CGRect(x:tagOriginX, y:tagOriginY, width:tagWidth, height:tagHeight))
            label.text = tag
            label.font = tagFont

            tagOriginX += tagWidth + tagMargin
        }
        return tagMargin + tagOriginY + CGFloat(tagHeight) + tagMargin //+ 30
    }

}
