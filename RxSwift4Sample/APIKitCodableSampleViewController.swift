//
//  APIKitCodableSampleViewController.swift
//  RxSwift4Sample
//
//  Created by cano on 2018/04/11.
//  Copyright © 2018年 cano. All rights reserved.
//
// APIKIt + Codable のサンプル
//

import UIKit
import APIKit

// https://codezine.jp/article/detail/10532?p=2
// RandomUser APIのレスポンスを受けとるオブジェクト
// resultsを格納する構造体
struct ResultListModel:Codable{    // ------（1）
    let results : [Person]
}

// ユーザー情報を格納する構造体
struct Person: Codable  {    // ------（2）
    let gender: String
    
    let name: Name    // ------（3）
    struct Name: Codable  {
        let title: String
        let first: String
        let last: String
    }
    
    let location: Location
    struct Location: Codable  {
        let street: String
        let city: String
        let state: String
        let postcode: Int
    }
    
    let email: String
}

// RandomUser APIへのリクエスト定義
// リクエストの定義 Request プロトコルに適合させ、最低5つの項目を実装する
// ・associatedtype Response
// ・var baseURL: URL { get }
// ・var method: HTTPMethod { get }
// ・var path: String { get }
// ・func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response
protocol RandomUserRequest: Request {
}

extension RandomUserRequest {
    var baseURL: URL {
        return URL(string: "https://randomuser.me/api/")!
    }
    
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

struct FetchRandomUserRequest: RandomUserRequest {
    typealias Response = ResultListModel
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ResultListModel {
        let decoder = JSONDecoder()
        return try decoder.decode(ResultListModel.self, from: object as! Data)
    }
    
    // Codable用
    var dataParser: DataParser {
        return JSONDataParser()
    }
}

// Codable用パーサークラス
class JSONDataParser: APIKit.DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        // ここではデコードせずにそのまま返す
        return data
    }
}

class APIKitCodableSampleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Session.send(FetchRandomUserRequest()) { result in
            //print(result)
            switch result {
                case .success(let res):
                    print("成功\n\(res)")
                
            case .failure(let err):
                    print("失敗\n\(err)")
            }
        }
        
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
