//
//  FlickrSearchViewController.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit
import Kingfisher

public enum ViewState {
    case none
    case loading
    case error
    case content
}

final class FlickrSearchViewController: UIViewController, FlickrSearchView {
    
    
    var presenter: FlickrSearchPresentation!
    let cellReuseIdentifier = "FlickrImageCell"
    
    var viewModel: FlickrImageListViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchController: UISearchController!
    
    public var currentState: ViewState = .none
    
    //MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flickr Search"
        
        // configure collectionView
        configureCollectionView()
        
        //configure searchController
        configureSearchController()
    
        presenter.searchFlickrImages(withText: "apple")
    }
    
    //MARK: configureCollectionView
    
    private func configureCollectionView() {
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(44, 0, 0, 0)
    }
    
    //MARK: configureSearchController
    
    private func configureSearchController() {
        let searchResultsVC = SearchResultsBuilder().buildSearchResultsModule()
        searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = searchResultsVC as? UISearchResultsUpdating
        searchController.searchBar.placeholder = "Search flickr for your favourite images"
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barStyle = .default
        definesPresentationContext = true
        collectionView?.addSubview(searchController.searchBar)
    }
    
    
    //MARK: FlickrSearchView
    func displayFlickrImageList(_  viewModel: FlickrImageListViewModel) {
        if self.viewModel == nil || self.viewModel?.photos.count == 0 {
            self.viewModel = viewModel
            DispatchQueue.main.async { [unowned self] in
                self.collectionView.reloadData()
                self.changeState(.content)
            }
        } else {
            guard self.viewModel != nil else {
                return
            }
            updateFlickrImageList(viewModel.photos)
        }
    }
    
    private func updateFlickrImageList(_ photos: [FlickerPhotoViewModel]) {
        DispatchQueue.main.async { [unowned self] in
            self.collectionView.performBatchUpdates({
                let oldCount = self.viewModel!.photos.count
                self.viewModel!.photos += photos
                var indexPaths: [IndexPath] = []
                for index in oldCount..<self.viewModel!.photos.count {
                    indexPaths.append(IndexPath(item: index, section: 0))
                }
                self.collectionView.insertItems(at: indexPaths)
            }, completion: { _ in
                self.changeState(.content)
            })
        }
    }
    
    func changeState(_ state: ViewState) {
        currentState = state
    }

}


//MARK: UICollectionViewDataSource and Delegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.photos.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FlickrImageCell
        
        if let viewModel = viewModel {
            let flickrPhoto = viewModel.photos[indexPath.row]
            cell.imageView.kf.setImage(with: flickrPhoto.imageUrl, options: [.transition(.fade(0.5))])
            
            if indexPath.row == viewModel.photos.count - 1 && indexPath.row < viewModel.total {
                presenter.searchFlickrImages(withText: "nature")
            }
        }
        return cell
    }
    
}

