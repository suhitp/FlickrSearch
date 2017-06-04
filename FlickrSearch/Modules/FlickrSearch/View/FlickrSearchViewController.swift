//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

final class FlickrSearchViewController: UIViewController, FlickrSearchView {
    
    var presenter: FlickrSearchPresentation!
    let cellReuseIdentifier = "FlickrImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flickr Search"
        
        presenter.searchFlickrImages(withText: "kitten")
    }
    
}


extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
    }
    
}
