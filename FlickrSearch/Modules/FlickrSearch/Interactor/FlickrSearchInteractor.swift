//
//  FlickrSearchInteractor.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import Foundation
import RxSwift

class FlickrSearchInteractor: FlickrSearchInteractorOutput {

    weak var output: FlickrSearchPresentation?
    let disposeBag = DisposeBag()
    
    func loadFlickrPhotos(forSearchText text: String, pageNum: Int)  {
       
        Networking.request(.images(searchText: text, pageNum: pageNum))
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (photos) in
                print(photos)
        }, onError: { (error) in
            print(error.localizedDescription)
        }).addDisposableTo(disposeBag)
    }
}
