//
//  CollectionViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/03/29.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

// 定义 Cell 类型
enum ItemType {
    case normal(title: String)
    case picture(title: String, image: UIImage)
    case subtitle(title: String, subtitle: String)
}
// 定义 Section 类型
enum Section {
    case `default`(title: String, items: [ItemType])
}
// 实现 SectionModelType 协议
extension Section : SectionModelType{
    
    typealias Sectoin = Section
    typealias Item = ItemType
    
    var items: [ItemType] {
        switch self {
        case .default(_, let items):
            return items
        }
    }
    
    var title: String {
        switch self {
        case .default(let title, _):
            return title
        }
    }
    
    init(original: Section, items: [Item]) {
        switch original {
        case .default(let title, let items):
            self = .default(title: title, items: items)
        }
    }
}

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // 定义数据源
    let sections = Variable<[Section]>([])
    //let dataSource = RxCollectionViewSectionedReloadDataSource<Section>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
