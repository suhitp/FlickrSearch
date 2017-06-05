//
//  FlickSearchAPI.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import Moya

public enum FlickrSearchAPI {
    case images(searchText: String, pageNum: Int)
}


extension FlickrSearchAPI: TargetType {
    
        public var baseURL: URL { return URL(string: "https://api.flickr.com")! }
    
        private var apiKey: String { return "3e7cc266ae2b0e0d78e279ce8e361736" }
    
        public var method: Moya.Method {
            switch self {
            case .images(_, _): return .get
            }
        }
    
        public var path: String {
            switch self {
            case .images(let searchText, let pageNum):
                return "/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&safe_search=1&text=\(searchText)&page=\(pageNum)&per_page=25"
            }
        }
            
        public var parameters: [String: Any]? {
            switch self {
            case .images(_, _):
                return nil
            }
        }
            
        public var parameterEncoding: ParameterEncoding {
            switch self {
            case .images(_, _):
                return JSONEncoding.default// Send parameters in URL
            }
        }
            
        public var task: Task {
            switch self {
            case .images(_, _):
                return .request
            }
        }
    
        public var sampleData: Data {
            return Data()
        }

}
