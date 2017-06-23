//
//  Networking.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import RxSwift
import Foundation
import Moya
import ObjectMapper


final class Networking {
    
    class func request(_ target: FlickrSearchAPI) -> Observable<FlickrPhotos> {
        return Observable<FlickrPhotos>.create { (observer) -> Disposable in
            let cancellableRequest = self.defaultProvider.request(target, completion: { (result) in
            switch result {
            case .success(let response):
                    
                do {
                    let jsonData = try response.filterSuccessfulStatusCodes()
                    let JSON = try jsonData.mapJSON() as! [String: Any]
                    let flickrPhotos = try Mapper<FlickrAPIResponse>().map(JSON: JSON)
                    observer.onNext(flickrPhotos.photos)
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
    
    // MARK: - Provider setup
    private class func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    
    static var defaultProvider: MoyaProvider<FlickrSearchAPI> {
        return MoyaProvider<FlickrSearchAPI>(endpointClosure: Networking.endPointClosure, plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])
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

