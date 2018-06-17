//
//  VMSampleViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/06/17.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VMSampleViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!

    // MARK: ivars
    private let disposeBag = DisposeBag()
    private lazy var presenter: Presenter = {
        let eventProvider = EventProvider(buttonTapped: self.button.rx.tap.asObservable())
        return Presenter(eventProvider: eventProvider)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.presenter.count
            .asDriver(onErrorJustReturn: 0)
            .map { currentCount in
                return "You have tapped that button \(currentCount) times."
            }
            .drive(self.label.rx.text)
            .disposed(by: disposeBag)
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
