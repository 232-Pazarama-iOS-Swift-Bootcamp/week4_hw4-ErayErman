//
//  SearchPhotoModel.swift
//  iOS-FlickrApp
//
//  Created by Eray on 20.10.2022.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let photos: SearchPhotos
    let stat: String
}

// MARK: - Photos
struct SearchPhotos: Codable {
    let page, pages, perpage, total: Int
    let photo: [SearchPhoto]
}

// MARK: - Photo
struct SearchPhoto: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let ownername: String
    let urlZ: String
    let heightZ, widthZ: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, ownername
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
    }
}
