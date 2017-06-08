//
//  UGDefaults.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 08/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import UIKit

struct UGDefaults {
    
    private static let userDefault = UserDefaults.standard
    
    //MARK: Retrieve
    static var flickrSearchData: [String] {
        guard let data = userDefault.object(forKey: Constants.flickrSearchDataKey) as? [String] else {
            return []
        }
        return data
    }
    
    //MARK: Save Data
    static func saveSearchText(_ text: String) {
        guard let data = userDefault.object(forKey: Constants.flickrSearchDataKey) as? [String] else {
            userDefault.set([text.capitalized], forKey: Constants.flickrSearchDataKey)
            return
        }
        
        let temp = data.filter {
            $0 == text.capitalized
        }
        if !temp.isEmpty { return }
        
        var array: [String] = data
        array.append(text)
        userDefault.set(array, forKey: Constants.flickrSearchDataKey)
    }
}
