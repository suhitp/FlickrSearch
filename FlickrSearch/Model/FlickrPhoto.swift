//
//  FlickrPhoto.swift
//  FlickrSearch
//
//  Created by Suhit Patil on 04/06/17.
//  Copyright © 2017 Suhit Patil. All rights reserved.
//

import ObjectMapper

struct FlickrAPIResponse: ImmutableMappable {
    let photos: FlickrPhotos
    
    init(map: Map) throws {
        photos = try map.value("photos")
    }
}

struct FlickrPhotos: ImmutableMappable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrPhoto]
    
    init(map: Map) throws {
        page = try map.value("page")
        pages = try map.value("pages")
        perpage = try map.value("perpage")
        total = try map.value("total")
        photo = try map.value("photo")
    }

}

struct FlickrPhoto: ImmutableMappable {

    let farm: Int
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
    
    init(map: Map) throws {
        farm = try map.value("farm")
        id = try map.value("id")
        owner = try map.value("owner")
        secret = try map.value("secret")
        server = try map.value("server")
        title = try map.value("title")
    }

}
