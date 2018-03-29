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
        
        self.collectionView.register(CollectionViewCell.self,
                                     forCellWithReuseIdentifier: "Cell")
        
        let items = Variable(Array(1...10))
        items.asObservable().bind(to: self.collectionView.rx.items(cellIdentifier: "Cell", cellType: CollectionViewCell.self)){ (_ , element, cell) in
            //セルのindex、対応する要素、セルが受け取れます。
            //数字を保持するだけの簡単なセルに突っ込んでいます。
            
            
            cell.label.text = "\(element)"
            
            }.disposed(by: self.rx.disposeBag)
        
        //下で設定してるdelegateをセットします。
        collectionView.rx.setDelegate(self).disposed(by: self.rx.disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                print(indexPath)
            }).disposed(by: self.rx.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    //セルの間の余白設定
    func  collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    //セルのサイズを指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 50)
    }
}

//自定义单元格
fileprivate class CollectionViewCell: UICollectionViewCell {
    
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景设为橙色
        self.backgroundColor = UIColor.orange
        
        //创建文本标签
        label = UILabel(frame: frame)
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.contentView.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
