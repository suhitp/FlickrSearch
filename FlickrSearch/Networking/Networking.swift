//
//  Networking.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import RxSwift
import Foundation
import Alamofire
import Moya
import ObjectMapper


final class Networking {
    
    class func request(_ target: FlickrSearchAPI) -> Observable<[FlickrPhoto]> {
        return Observable<[FlickrPhoto]>.create { (observer) -> Disposable in
            let cancellableRequest = self.defaultProvider.request(target, completion: { (result) in
            switch result {
            case .success(let response):
                    
                do {
                    let json = try response.filterSuccessfulStatusCodes()
                    let photos = try json.mapJSON()
                    print(photos)
                    observer.onNext([])
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create {
                cancellableRequest.cancel()
            }

        }
    }
    
    static var defaultProvider: MoyaProvider<FlickrSearchAPI> {
        return MoyaProvider<FlickrSearchAPI>(endpointClosure: Networking.endPointClosure, plugins: [NetworkLoggerPlugin(verbose: false)])
    }
    
    static var endPointClosure = { (target: FlickrSearchAPI) -> Endpoint<FlickrSearchAPI> in
        
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString.removingPercentEncoding!
        
        return Endpoint<FlickrSearchAPI>(url: url,
                                         sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                         method: target.method,
                                         parameters: target.parameters,
                                         parameterEncoding: target.parameterEncoding)
        
    }
    
}


struct FlickrPhoto {
    
    let title: String
    let url: NSURL
    let identifier: String
    
    init (title: String, url: NSURL, identifier: String) {
        self.title = title
        self.url = url
        self.identifier = identifier
    }
    
}
