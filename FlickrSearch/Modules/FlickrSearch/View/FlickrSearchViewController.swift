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
    
    var viewModel: FlickrImageListViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flickr Search"
        
        presenter.searchFlickrImages(withText: "kitten")
    }
    
    func displayFlickrImageList(_  viewModel: FlickrImageListViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

//
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FlickrImageCell
        return cell
    }
    
}


