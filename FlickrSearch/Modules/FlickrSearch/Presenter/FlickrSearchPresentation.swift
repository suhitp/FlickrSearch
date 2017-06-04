//
//  FlickrSearchPresentation.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

protocol FlickrSearchPresentation: class {
    weak var view: FlickrSearchView? { get set }
    var interactor: FlickrSearchInteractor! { get set }
    var router: FlickrSearchRouter! { get set }
}
