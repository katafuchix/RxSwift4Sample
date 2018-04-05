//
//  AnimatingTableViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/06.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit

class AnimatingTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 124
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnimatingTableViewCell
        cell.delegate = self
        return cell
    }
}

extension AnimatingTableViewController: CellDelegate {
    func contentDidChange(cell: AnimatingTableViewCell) {
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
}
