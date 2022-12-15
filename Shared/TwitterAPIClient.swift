//
//  TwitterAPIClient.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/15/21.
//

import Foundation
import Alamofire

struct PropertyList: Codable {
    var twitterBearer : String
}

class TwitterClient {
    static var api = TwitterClient()
    private var baseURL = "https://api.twitter.com/2"
    private var search:  String {
        return baseURL + "/tweets/search/recent?"
    }
    
    private var token: String? {
        if  let path        = Bundle.main.path(forResource: "apiKeys", ofType: "plist"),
            let xml         = FileManager.default.contents(atPath: path),
            let plist = try? PropertyListDecoder().decode(PropertyList.self, from: xml)
        {
            return plist.twitterBearer
            
        }
        return nil
    }
    
    private var headers: HTTPHeaders{
        return [.authorization(bearerToken: token ?? "")]
    }
    
    func search(for query: String, completionHandler: @escaping (_ result: TweetList?) -> Void){
        var searchParameters: Parameters{
            return [
                "query" : "entity: \"$" + query + "\"",
                "max_results": "100",
                "tweet.fields": "attachments,conversation_id,author_id,in_reply_to_user_id,created_at",
                "expansions": "attachments.media_keys,attachments.poll_ids,referenced_tweets.id,in_reply_to_user_id,author_id",
                "media.fields": "url,preview_image_url",
                "user.fields": "profile_image_url",
            ]
        }
        
        
        AF.request(search, method: .get, parameters: searchParameters, encoding: URLEncoding.queryString, headers: headers)
            .responseDecodable(of: TweetList.self){ list in
            guard let data = list.value else {
                completionHandler(nil)
                return
            }
            return completionHandler(data)
        }

    }
}
