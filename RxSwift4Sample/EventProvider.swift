//
//  EventProvider.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/06/17.
//  Copyright © 2018年 cano. All rights reserved.
//

import RxSwift
import RxCocoa

struct EventProvider {
    let buttonTapped: Observable<Void>
}

struct Presenter {

    let count: Observable<Int>

    init(eventProvider: EventProvider) {
        self.count =
            eventProvider.buttonTapped.scan(0) { (previousValue, _) in
                return previousValue + 1
        }
    }

}
