//
//  FlickrSearchBuilder.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

public protocol FlickrSearchModuleBuilder {
    func buildFlickrSearchModule() -> UIViewController?
}

final class FlickrSearchBuilder: FlickrSearchModuleBuilder {
    
     func buildFlickrSearchModule() -> UIViewController? {
       
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlickrSearchViewController") as? FlickrSearchViewController
        
        let presenter = FlickrSearchPresenter()
        let router = FlickrSearchRouter()
        let interactor = FlickrSearchInteractor()
        
        
        viewController?.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.viewController = viewController
        
        interactor.output = presenter
        
        return viewController
    }

}



