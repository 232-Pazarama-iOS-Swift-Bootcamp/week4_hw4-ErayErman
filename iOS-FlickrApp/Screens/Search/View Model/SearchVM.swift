//
//  SearchVM.swift
//  iOS-FlickrApp
//
//  Created by Eray on 18.10.2022.
//

import Foundation
import Moya

enum SearchChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchSearchPhotos
}

final class SearchVM {
    
     private var searchResponse: SearchResponse? {
         didSet {
             self.changeHandler?(.didFetchSearchPhotos)
         }
     }
     
     var changeHandler: ((SearchChanges) -> Void)?
     
     var numberOfRows: Int {
         searchResponse?.photos.photo.count ?? .zero
     }
     
    func fetchSearch(with: String) {
         flickrSearchApiProvider.request(.getSearchingPhotos) { result in
             switch result {
             case .failure(let error):
                 self.changeHandler?(.didErrorOccurred(error))
             case .success(let response):
                 do {
                     let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: response.data)
                     self.searchResponse = searchResponse
                 } catch {
                     self.changeHandler?(.didErrorOccurred(error))
                 }
             }
         }
     }
     
     func coinForIndexPath(_ indexPath: IndexPath) -> SearchPhoto? {
         searchResponse?.photos.photo[indexPath.row]
     }
    
    
}

