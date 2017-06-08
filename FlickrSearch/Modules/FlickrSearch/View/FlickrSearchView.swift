//
//  FlickrSearchView.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit
import Foundation

protocol FlickrSearchView: class {
    var presenter: FlickrSearchPresentation! { get set }
    var currentState: ViewState { get set }
    func displayFlickrImageList(_  viewModel: FlickrImageListViewModel)
    func showFlickrSearchError(_ error: Error)
    func changeState(_ state: ViewState)
}
