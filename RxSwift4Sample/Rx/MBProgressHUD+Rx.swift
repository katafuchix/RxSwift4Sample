//
//  MBProgressHUD+Rx.swift
//  Pochi
//
//  Created by 古林俊佑 on 2017/02/05.
//  Copyright © 2017年 ShunsukeFurubayashi. All rights reserved.
//

import UIKit
import MBProgressHUD
import RxSwift
import RxCocoa

extension Reactive where Base: MBProgressHUD {
    static func isAnimating(view: UIView) -> AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()

            switch event {
            case .next(let value):
                if value {
                    MBProgressHUD.showAdded(to: view, animated: true)
                } else {
                    MBProgressHUD.hide(for: view, animated: true)
                }
            default:
                break
            }

        }
    }
}
