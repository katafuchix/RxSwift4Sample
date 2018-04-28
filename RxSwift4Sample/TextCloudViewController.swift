//
//  TextCloudViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/25.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

class TextCloudViewController: UIViewController {

    let words = [
        "Ruby",
        "Ruby on Rails",
        "JavaScript",
        "Swift",
        "iOS",
        "HTML",
        "CSS",
        "Perl",
        "Python",
        "PHP",
        "Java",
        "Scala",
        "Go",
        "Elixir",
        "Objective-C"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tagsView = UIView(frame: CGRect(x:50, y:200, width:view.bounds.size.width - 50 * 2, height:200))  // 高さは適当な大きさに
        view.addSubview(tagsView)
        placeTagsOn(tagsView: tagsView, tags: words)
    }

    func placeTagsOn(tagsView: UIView, tags: [String]) {
        let areaWidth = tagsView.bounds.size.width
        let tagMargin: CGFloat = 10
        let tagFont = UIFont.systemFont(ofSize: 16)
        let tagHeight = tagFont.lineHeight + TagLabel().tagPadding * 2

        var tagOriginX: CGFloat = 0
        var tagOriginY: CGFloat = 0

        for tag in tags {
            var tagWidth = tagLabelTextWidth(text: tag, font: tagFont, height: tagHeight)
            if tagWidth > areaWidth {
                tagWidth = areaWidth
            }

            if areaWidth - tagOriginX < tagWidth {
                tagOriginX = 0
                tagOriginY += tagHeight + tagMargin
            }

            let label = TagLabel(frame: CGRect(x:tagOriginX, y:tagOriginY, width:tagWidth, height:tagHeight))
            label.text = tag
            label.font = tagFont
            tagsView.addSubview(label)

            tagOriginX += tagWidth + tagMargin

            print("tagOriginY : \(tagOriginY)")
        }
    }

    func tagLabelTextWidth(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x:0, y:0, width:CGFloat.greatestFiniteMagnitude, height:height))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size.width + TagLabel().tagPadding * 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
