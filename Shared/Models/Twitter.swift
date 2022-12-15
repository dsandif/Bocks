//
//  Twitter.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/28/21.
//

import Foundation

//// MARK: - Tweet
//struct Tweet: Codable, Identifiable {
//    let id = UUID()
//    let authorID, createdAt: String
//    let entities: Entities?
//    let tweet_id, lang: String
//    let possiblySensitive: Bool
//    let referencedTweets: [ReferencedTweet]?
//    let source, text: String
//
//    enum CodingKeys: String, CodingKey {
//        case authorID = "author_id"
//        case tweet_id = "id"
//        case createdAt = "created_at"
//        case entities, lang
//        case possiblySensitive = "possibly_sensitive"
//        case referencedTweets = "referenced_tweets"
//        case source, text
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tweetList = try? newJSONDecoder().decode(TweetList.self, from: jsonData)

import Foundation

// MARK: - TweetList
struct TweetList: Codable {
    let data: [Tweet]?
    let includes: Includes?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case data = "data"
        case includes = "includes"
        case meta = "meta"
    }
}

// MARK: - Tweet
struct Tweet: Codable {
    let referencedTweets: [ReferencedTweet]?
    let text: String
    let conversationId: String?
    let createdAt: String
    let id: String?
    let authorId: String
    let inReplyToUserId: String?
    let attachments: Attachments?

    enum CodingKeys: String, CodingKey {
        case referencedTweets = "referenced_tweets"
        case text = "text"
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case id = "id"
        case authorId = "author_id"
        case inReplyToUserId = "in_reply_to_user_id"
        case attachments = "attachments"
    }
    
    func findUserForTweet(data: [User] = []) -> User? {
        let foundUsers = data.filter({ u in
            return u.id == self.authorId
        })
        
        return (foundUsers.count != 0) ? foundUsers[0] : nil
    }
}

// MARK: - Attachments
struct Attachments: Codable {
    let mediaKeys: [String]?
    let pollIds: [String]?

    enum CodingKeys: String, CodingKey {
        case mediaKeys = "media_keys"
        case pollIds = "poll_ids"
    }
}

// MARK: - ReferencedTweet
struct ReferencedTweet: Codable {
    let type: ReferencedTweetType?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
    }
}

enum ReferencedTweetType: String, Codable {
    case quoted = "quoted"
    case repliedTo = "replied_to"
    case retweeted = "retweeted"
}

// MARK: - Includes
struct Includes: Codable {
    let users: [User]?
    let tweets: [Tweet]?
    let media: [Media]?
    let polls: [Poll]?

    enum CodingKeys: String, CodingKey {
        case users = "users"
        case tweets = "tweets"
        case media = "media"
        case polls = "polls"
    }
}

// MARK: - Media
struct Media: Codable {
    let mediaKey: String?
    let type: MediaType?
    let url: String?
    let previewImageUrl: String?

    enum CodingKeys: String, CodingKey {
        case mediaKey = "media_key"
        case type = "type"
        case url = "url"
        case previewImageUrl = "preview_image_url"
    }
}

enum MediaType: String, Codable {
    case animatedGif = "animated_gif"
    case photo = "photo"
}

// MARK: - Poll
struct Poll: Codable {
    let id: String?
    let options: [Option]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case options = "options"
    }
}

// MARK: - Option
struct Option: Codable {
    let position: Int?
    let label: String?
    let votes: Int?

    enum CodingKeys: String, CodingKey {
        case position = "position"
        case label = "label"
        case votes = "votes"
    }
}

// MARK: - User
struct User: Codable {
    let profileImageUrl: String?
    let name: String?
    let username: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case profileImageUrl = "profile_image_url"
        case name = "name"
        case username = "username"
        case id = "id"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let newestId: String?
    let oldestId: String?
    let resultCount: Int?
    let nextToken: String?

    enum CodingKeys: String, CodingKey {
        case newestId = "newest_id"
        case oldestId = "oldest_id"
        case resultCount = "result_count"
        case nextToken = "next_token"
    }
}
