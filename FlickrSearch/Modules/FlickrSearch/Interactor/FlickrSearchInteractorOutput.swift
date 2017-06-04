//
//  FlickrSearchInteractorOutput.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

protocol FlickrSearchInteractorOutput: class {
    weak var output: FlickrSearchPresentation? { get set }
}
