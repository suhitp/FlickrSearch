//
//  SearchResultsBuilder.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 08/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

public protocol SearchResultsModuleBuilder {
    func buildSearchResultsModule() -> UIViewController
}

final class SearchResultsBuilder: SearchResultsModuleBuilder {
   
    func buildSearchResultsModule() -> UIViewController {
        
        let viewController = SearchResultsViewController()
        
       /* let presenter = SearchResultsPresenter()
        let router = SearchResultsRouter()
        let interactor = SearchResultsInteractor()
        
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.viewController = viewController
        
        interactor.output = presenter */
        
        return viewController
    }

}



