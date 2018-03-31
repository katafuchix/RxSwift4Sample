//
//  SBCollectionViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/03/31.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

struct CustomData {
    var str: String
}
struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData
    
    init(original: SectionOfCustomData, items: [SectionOfCustomData.Item]) {
        self = original
        self.items = items
    }
}

class SBCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 100)
        
        self.collectionView.register(MySectionHeader.self,
                                     forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                     withReuseIdentifier: "Section")
        flowLayout.headerReferenceSize = CGSize(width: self.view.frame.width, height: 40)
        self.collectionView.collectionViewLayout = flowLayout
        
        let dataSource = RxCollectionViewSectionedReloadDataSource
            <SectionOfCustomData>(
                configureCell: { (dataSource, collectionView, indexPath, element) in
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                                  for: indexPath) as! SBCollectionViewCell
                    cell.label.text = "\(element)"
                    return cell
                    
                },
                configureSupplementaryView: {
                    (ds ,cv, kind, ip) in
                    let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "Section", for: ip) as! MySectionHeader
                    section.label.text = ds.sectionModels[ip.section].header
                    return section
            }
        )
        
        let sections = [
            SectionOfCustomData(header: "First section",
                                items: [CustomData(str: "zero"),
                                        CustomData(str: "one") ]),
            SectionOfCustomData(header: "Second section",
                                items: [CustomData(str: "two"),
                                        CustomData(str: "three") ])
        ]
        
        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: self.rx.disposeBag)
        
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

class SBCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}

class MySectionHeader: UICollectionReusableView {
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //背景设为黑色
        self.backgroundColor = UIColor.black
        
        //创建文本标签
        label = UILabel(frame: frame)
        label.textColor = UIColor.white
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


