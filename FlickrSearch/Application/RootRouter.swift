//
//  RootRouter.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

final public class RootRouter {
    
    static func configureFlickrSearchScreen(inWindow window: UIWindow) {
        guard let flickrSearchViewController = FlickrSearchBuilder().buildFlickrSearchModule() as?FlickrSearchViewController else {
            return
        }
        
        let navigationController = getRootNavigationController()
        navigationController.setViewControllers([flickrSearchViewController], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    static func getRootNavigationController() -> UINavigationController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
    }
}
