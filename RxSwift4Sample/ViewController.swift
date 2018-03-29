//
//  ViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/02/25.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var input: UITextField!
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    let disposeBag = DisposeBag() //unsubscribeに必要なもの
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.input.rx.text.orEmpty
            //.throttle(1.0, scheduler: MainScheduler.instance)
            //.distinctUntilChanged()
            .subscribe(onNext: { [unowned self] text in
                self.label.text = text
            })
            .disposed(by: self.disposeBag)
        
        Observable.combineLatest(textField1.rx.text.orEmpty.asObservable(), textField2.rx.text.orEmpty.asObservable()){
            $0.characters.count > 0 && $1.characters.count > 0
            }
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        let strOb = PublishSubject<String>()
        let intOb = PublishSubject<Int>()
        
        _ = Observable.combineLatest(strOb, intOb) {
            "\($0) \($1)"
            }
            .subscribe {
                print($0)
        }
        
        strOb.onNext("A")
        intOb.onNext(1)
        strOb.onNext("B")
        intOb.onNext(2)
        
        /*
        let helloSequence = Observable.of("Hello Rx")
        _ = helloSequence.subscribe { event in
            print(event)
        }
        */
        let helloSequence = Observable.from(["H","e","l","l","o"])
        let subscription = helloSequence.subscribe { event in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

