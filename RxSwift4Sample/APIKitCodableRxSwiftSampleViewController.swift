//
//  APIKitCodableRxSwiftSampleViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/11.
//  Copyright © 2018年 cano. All rights reserved.
//
// APIKIt + Codable + RxSwift のサンプル
//

import UIKit
import Foundation
import APIKit
import RxSwift
import Result

// APIKit の Session.sendRequest に Observable を実装する
/**
 * Session for using RxSwift extension
 * - Url: https://qiita.com/natmark/items/5d8cd792d5aae364842f
 */
extension Session {
    
    /**
     * APIKit send action on RxSwift Observable
     * - Parameters:
     *   - request: Request object as APIKit
     */
    public func rx_sendRequest<T: Request>(_ request: T) -> Observable<T.Response> {
        return Observable.create { observer in
            let task = self.send(request) { result in
                switch result {
                case .success(let response):
                    observer.on(.next(response))
                    observer.on(.completed)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    /**
     * APIKit send action on RxSwift Observable
     * - Parameters:
     *   - request: Request object as APIKit
     */
    public class func rx_sendRequest<T: Request>(_ request: T) -> Observable<T.Response> {
        return shared.rx_sendRequest(request)
    }
    
}

class APIKitCodableRxSwiftSampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // RXSwift + APIKit を利用してAPIをコール
        FetchRandomUserRequest().asObservable().subscribe(
                onNext: { res in
                    print("ok")
                    print(res)
                },
                onError: { err in
                    print("error")
                    print(err)
                }
            ).disposed(by: rx.disposeBag)
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
