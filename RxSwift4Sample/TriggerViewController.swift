//
//  TriggerViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/06/16.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import NSObject_Rx

class TriggerViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    let HUD = MBProgressHUD.init()
    //let isLoading = Observable<Bool>()
    let sendTrigger = PublishSubject<Void>()
    //let isLoading = PublishSubject<Bool>()

    let buttonHiddenSubject = BehaviorSubject(value: true)

    var buttonHidden: Observable<Bool> { return buttonHiddenSubject }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //let HUD = MBProgressHUD.init()
        self.view.addSubview(HUD)
        //HUD.show(animated: true)

        //let isLoading = BehaviorRelay(value: false)
        //let isLoading = Observable.just(false)

        let enabledSubject = BehaviorSubject<Bool>(value: false)
        //var isLoading = Observable<Bool>.startWith(false)

/*
        self.button.rx.tap.asObservable().subscribe(onNext:
            {print($0)}
            ).disposed(by: self.rx.disposeBag)
*/
        self.button.rx.tap.asDriver()
            .drive(sendTrigger)
            .disposed(by: self.rx.disposeBag)

        buttonHidden.subscribe(onNext:
            { print($0) })
            .disposed(by: self.rx.disposeBag)
        //.asDriver().drive(MBProgressHUD.rx.isAnimating(view: view)).disposed(by: self.rx.disposeBag)

        sendTrigger.asObserver().subscribe(onNext:
            {print($0)}
        ).disposed(by: self.rx.disposeBag)
/*
        sendTrigger.asObservable()
            .withLatestFrom(buttonHidden)
        .bind(to: self.button.rx.isEnabled)
            //.map { $0 }
        .disposed(by: self.rx.disposeBag)
*/


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
