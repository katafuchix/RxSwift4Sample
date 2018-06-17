//
//  TextFieldSampleViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/06/17.
//  Copyright © 2018年 cano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class TextFieldSampleViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        Observable.combineLatest(self.userNameTextField.rx.text,
                                 self.passwordTextField.rx.text)
        {(username, password) in return username != nil && password != nil}
        .bind(to: self.button.rx.isEnabled)
        .disposed(by: self.rx.disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
