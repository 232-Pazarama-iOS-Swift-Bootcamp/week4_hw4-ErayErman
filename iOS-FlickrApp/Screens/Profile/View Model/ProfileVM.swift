//
//  ProfileVM.swift
//  iOS-FlickrApp
//
//  Created by Eray on 18.10.2022.
//

import Foundation
import Moya


 enum ProfilePhotosChanges {
     case didErrorOccurred(_ error: Error)
     case didFetchRecentPhotos
 }

 final class ProfileVM {
     
     private var recentsResponse: RecentPhotoResponse? {
          didSet {
              self.changeHandler?(.didFetchRecentPhotos)
          }
      }
      
      var changeHandler: ((RecentPhotosChanges) -> Void)?
      
      var numberOfRows: Int {
          recentsResponse?.photos?.photo.count ?? .zero
      }
      
      func fetchPhotos() {
          flickrApiProvider.request(.getRecentPhotos) { result in
              switch result {
              case .failure(let error):
                  self.changeHandler?(.didErrorOccurred(error))
              case .success(let response):
                  do {
                      let recentsResponse = try JSONDecoder().decode(RecentPhotoResponse.self, from: response.data)
                      self.recentsResponse = recentsResponse
                  } catch {
                      self.changeHandler?(.didErrorOccurred(error))
                  }
              }
          }
      }
      
      func photoForIndexPath(_ indexPath: IndexPath) -> Photo? {
          recentsResponse?.photos?.photo[indexPath.row]
      }

     
 }
