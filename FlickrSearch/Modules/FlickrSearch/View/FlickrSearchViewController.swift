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
    let footerReuseIdentifier = "CustomFooterReuseIdentifier"
    
    var viewModel: FlickrImageListViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var searchController: UISearchController!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    public var currentState: ViewState = .none
    
    var searchText = "uber"
    
    //MARK: Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Flickr Search"
        
        // configure collectionView
        configureCollectionView()
        
        //configure searchController
        configureSearchController()
        
        //search images
        spinner.startAnimating()
        presenter.searchFlickrImages(withText: searchText)
    }
    
    //MARK: configureCollectionView
    
    private func configureCollectionView() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
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
                self.spinner.stopAnimating()
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
    
    func showFlickrSearchError(_ error: Error) {
        //TO-DO show error with retry option
        changeState(.error)
        print(error.localizedDescription)
    }
    
    func changeState(_ state: ViewState) {
        currentState = state
    }
    
    //MARK: Private
    private func updateFlickrImageList(_ photos: [FlickerPhotoViewModel]) {
        DispatchQueue.main.async { [unowned self] in
            self.spinner.stopAnimating()
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
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        if indexPath.row == viewModel.photos.count - 1 && indexPath.row < viewModel.total {
            presenter.searchFlickrImages(withText: searchText)
        }
    }
    //MARK: Footer
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if currentState == .loading && viewModel != nil {
            return CGSize(width: view.frame.size.width, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,  at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath) as! CustomFooterView
            footerView.backgroundColor = .white
            footerView.spinner.startAnimating()
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
}

