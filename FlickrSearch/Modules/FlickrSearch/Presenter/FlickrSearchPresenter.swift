//
//  FlickrSearchPresenter.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

class FlickrSearchPresenter: FlickrSearchPresentation {
    weak var view: FlickrSearchView?
    var interactor: FlickrSearchInteractor!
    var router: FlickrSearchRouter!
}
