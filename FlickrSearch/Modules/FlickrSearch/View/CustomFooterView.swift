//
//  CustomFooterView.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 08/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

class CustomFooterView: UICollectionReusableView {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinner.hidesWhenStopped = true
    }
}
