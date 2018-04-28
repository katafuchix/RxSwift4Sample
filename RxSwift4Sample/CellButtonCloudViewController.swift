//
//  CellButtonCloudViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/26.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CellButtonCloudViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var datasource = [SectionOfCustomData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.datasource = self.makeDummyData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // ダミーデータ
    // APIから取得したJSONを元に次のようなデータを作成します
    func makeDummyData()->[SectionOfCustomData] {
        return [
            SectionOfCustomData(header: "地域",
                                items: [CustomData(str: "渋谷"),
                                        CustomData(str: "新宿"),
                                        CustomData(str: "六本木"),
                                        CustomData(str: "札幌"),
                                        CustomData(str: "仙台"),
                                        CustomData(str: "名古屋"),
                                        CustomData(str: "大阪"),
                                        CustomData(str: "福岡"),
                                        CustomData(str: "鹿児島")
                ]),

            SectionOfCustomData(header: "募集期間",
                                items: [CustomData(str: "24時間"),
                                        CustomData(str: "1日間"),
                                        CustomData(str: "1週間"),
                                        CustomData(str: "2週間"),
                                        //CustomData(str: "3週間"),
                                        //CustomData(str: "１ヶ月")
                ]),

            SectionOfCustomData(header: "目的",
                                items: [CustomData(str: "気軽に"),
                                        CustomData(str: "サクッと"),
                                        CustomData(str: "朝まで"),
                                        CustomData(str: "その後二次会"),
                                        CustomData(str: "歌いたい")
                ])
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CellButtonCloudViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ButtonCloudCell.self), for: indexPath) as! ButtonCloudCell
        cell.placeTagsOn(tags: datasource[indexPath.row].items.map{ $0.str })
        return cell
    }

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 高さを計算
        return ButtonCloudCell.getCellHeight(width:self.view.bounds.width, tags: datasource[indexPath.row].items.map{ $0.str })
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
