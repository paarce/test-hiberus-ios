//
//  ApiManage.swift
//  Cards CR Hiberus
//
//  Created by Augusto C.P. on 10/28/19.
//  Copyright © 2019 Augusto C.P. All rights reserved.
//

import Foundation
import Moya

let provider = MoyaProvider<Api>()

enum Api {
    case cards
}


extension Api: TargetType {
    
    var baseURL: URL { return URL(string: "http://www.clashapi.xyz/api/")! }
    
    var headers: [String : String]? {
        
        return [ : ]
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .cards:
            return "cards"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {
        case .cards
            :
            return .get
            
        }
        
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        
        switch self {
        case .cards :
            return .requestPlain
        }
        
    }
    
    static func request<T: Codable>(endpoint : Api, completationBool: ((Result<Bool,ErrorApi>) -> Void)? = nil, completation: ((Result<T,ErrorApi>) -> Void)? = nil)  {
        provider.rx.request(endpoint).subscribe { event in
            switch event {
            case let .success(response):
                switch response.statusCode{
                case 200...299:
                    //response.printToString()
                    //print(response.request?.url)
                    if let completationBool = completationBool {
                        completationBool(.success(true))
                    }else if let completation = completation {
                        
                        do {
                            let data = try JSONDecoder().decode(T.self, from: response.data)
                            completation(.success(data))
                        }
                        catch (let error) {
                            print(error)
                            completation(.failure(.Error(ErrorModel(statusCode: 400, message: "Some went wrong with the response format"))))
                        }
                        
                    }else {
                        completation?(.failure(.Error(ErrorModel(statusCode: 400, message: "Some went wrong"))))
                    }
                    
                default:
                    let msg = String(data: response.data, encoding: String.Encoding.utf8) as String?
                    let ErrorMap = ErrorModel(statusCode: response.statusCode, message: msg)
                    completation?(.failure(.Error(ErrorMap)))
                    completationBool?(.failure(.Error(ErrorMap)))
                    
                    break
                }
                
            case let .error(error):
                completation?(.failure(.Error(ErrorModel(statusCode: 400, message: "Please check your conenction"))))
            }
            }
            .disposed(by: disposbag)
    }
    
}

extension Response {
    
    func printToString() {
        let jsonReponse = try? self.mapJSON()
        let jsontest = jsonReponse as? [String: Any]
        print(jsontest as Any)
    }
    
}


