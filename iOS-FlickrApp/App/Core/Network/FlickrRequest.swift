import Foundation
import Moya

 let flickrApiProvider = MoyaProvider<FlickrAPI>()

 enum FlickrAPI {
     case getRecentPhotos
 }

 extension FlickrAPI: TargetType {
     
     //https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&format=json&nojsoncallback=1&api_key=c4f5449b51ab89b5b94ffdbea7f71a2c&extras=owner_name%2C+url_c
     
     var baseURL: URL {
         guard let url = URL(string: "https://www.flickr.com/services/rest") else {
             fatalError("Base URL not found or not in correct format.")
         }
         return url
     }
     
     var path: String {
         "/"
     }
     
     var method: Moya.Method {
         .get
     }
     
     var task: Moya.Task {
         let parameters: [String : Any] = ["method" : "flickr.photos.getRecent",
                                           "format" : "json",
                                           "nojsoncallback" : 1,
                                           "api_key" : "c4f5449b51ab89b5b94ffdbea7f71a2c",
                                           "extras" : "owner_name,url_c"]
         return .requestParameters(parameters:  parameters, encoding: URLEncoding.queryString)
     }
     
     var headers: [String : String]? {
         nil
     }
 }


