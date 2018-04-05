//
//  ExpandingTableViewViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/05.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

class ExpandingTableViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var datasource = [ExpandingTableViewCellContent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView() // Removes empty cell separators
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        datasource = [ExpandingTableViewCellContent(title: "Vestibulum id ligula porta felis euismod semper.",
                                                    subtitle: "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas sed diam eget risus varius blandit sit amet non magna."),
                      ExpandingTableViewCellContent(title: "Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis .",
                                                    subtitle: "Etiam porta sem malesuada magna mollis euismod. Nullam quis risus urna mollis ornare vel eu leo."),
                      ExpandingTableViewCellContent(title: "Aenean lacinia bibendum nulla sed consectetur.",
                                                    subtitle: "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec id elit non mi porta gravida at eget metus.")]
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ExpandingTableViewViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: String(describing: ExpandingTableViewCell.self), for: indexPath) as! ExpandingTableViewCell
        cell.set(content: datasource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = datasource[indexPath.row]
        content.expanded = !content.expanded
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
