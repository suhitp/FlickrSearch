//
//  FlickrSearchPresenter.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit
import RxSwift
import Foundation

class FlickrSearchPresenter: FlickrSearchPresentation {
    weak var view: FlickrSearchView?
    var interactor: FlickrSearchInteractor!
    var router: FlickrSearchRouter!
    
    var pageNum = -1
    var flickrImageListViewModel = FlickrImageListViewModel()
    var total_items = -1
    
    func searchFlickrImages(withText text: String) {
        guard view?.currentState != .loading else {
            return
        }
        guard total_items < flickrImageListViewModel.total else {
            return
        }
        view?.changeState(.loading)
        pageNum += 1
        interactor.loadFlickrPhotos(forSearchText: text, pageNum: pageNum)
    }
    
    func onFlickSearchSuccess(_ flickrPhotos: FlickrPhotos) {
        if flickrImageListViewModel.total == 0 {
            flickrImageListViewModel = FlickrImageListViewModel(photos: buildViewModel(flickrPhotos.photo), total: Int(flickrPhotos.total)!)
        } else {
            flickrImageListViewModel.photos += buildViewModel(flickrPhotos.photo)
        }
        total_items += flickrPhotos.photo.count
        view?.displayFlickrImageList(flickrImageListViewModel)
    }
    
    func onFlickSearchError(_ error: Error) {
        pageNum -= 1
        view?.showFlickrSearchError(error)
    }
}

extension FlickrSearchPresenter {
    
    fileprivate func buildViewModel(_ photos: [FlickrPhoto]) -> [FlickerPhotoViewModel] {
        let photoViewModel: [FlickerPhotoViewModel] = photos.map { (photo) in
            let url = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
            return FlickerPhotoViewModel(imageUrl: URL(string: url)!)
        }
        return photoViewModel
    }
}


struct FlickrImageListViewModel {
    var photos: [FlickerPhotoViewModel] = []
    var total: Int = 0
}

struct FlickerPhotoViewModel {
    let imageUrl: URL
}

/*
 https://farm{farm}.static.flickr.com/{server}/{id}_{secret}.jpg
 So, using our example from before, the URL would be
 https://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg
 */
