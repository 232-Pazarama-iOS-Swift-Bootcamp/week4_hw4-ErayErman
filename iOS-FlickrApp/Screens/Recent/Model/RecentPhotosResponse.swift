//
//  RecentPhotosResponse.swift
//  iOS-FlickrApp
//
//  Created by Eray on 19.10.2022.
//

import Foundation

struct RecentPhotoResponse: Codable {
    let photos: Photos?
    let stat: String?
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]
}
