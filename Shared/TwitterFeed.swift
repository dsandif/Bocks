//
//  TwitterFeed.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import SwiftUI
import SwiftDate

struct TwitterFeed: View {
    @Binding var symbol: String
//    #if DEBUG
//    @State var feed: [Tweet] = TwitterFeed_Previews.testTweets
//    #else
    @State var feed: [Tweet] = []
    @State var includedUserData: [User] = []
    @State private var loadingData = true
    var priceType: PriceType
//    #endif

    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Image("twitter")
                    .resizable()
                    .frame(width: 22, height: 22)
                Text("What's Happening")
                    .fontWeight(.heavy)
            }

            Divider().frame(height:2).background(AppColors.white)
            if(feed.isEmpty && loadingData == false){
                Text("No recent activity")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .background(Color(UIColor.init(priceType.color).add(overlay: UIColor(white: 0, alpha: 0.1))))
            }
            
            ScrollView(.vertical, showsIndicators: false){
                ForEach(feed, id: \.id){ tweet in
                    if(loadingData == false){
                        Spacer()
                        TweetView(tweet: tweet, pricetype: priceType, userData: includedUserData)
                            
                        Spacer()
                    }
                }
            }
        }
        .onAppear(perform: {loadData()})
    }
}


struct TweetView: View {
    var tweet: Tweet
    var pricetype: PriceType
    var userData: [User] = []
    var names = [
        "Deron Johnson",
        "Leon Gill",
        "Josh Choo",
        "Allen Cooper",
        "Jack Patrick"
    ]
    var colors = [
        Color.red,
        Color.orange,
        Color.yellow,
        Color.green,
        Color.blue,
        Color.purple
    ]
    
    var user: User{
        return tweet.findUserForTweet(data: userData)!
    }
    
    var body: some View {
         HStack(alignment: .top, spacing: 12) {
             VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 15){
                    Text(tweet.text)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "57606f"))
                    
                    HStack(spacing: 32) {
                        Image(systemName: "bubble.right")
                        Image(systemName: "arrow.2.squarepath")
                        Image(systemName: "heart")
                        Image(systemName: "square.and.arrow.up")
                    }
                    .padding(.top, 12)
                    .font(.title3)
                    .foregroundColor(.secondary)
                }
                .padding(5)
                
                VStack{
                    Divider()
                    HStack(alignment: .center) {
                       URLImage(url: URL(string: user.profileImageUrl!)!)
                            .body
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .border(Color(hex: "a4b0be"), width: 1)
                            .frame(width: 30.0, height: 30.0, alignment: .center)
                            .clipped()
                        VStack(alignment: .leading){
                            Text("@\(user.username!)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "a4b0be"))
                            HStack{
                                Text(user.name!)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(hex: "a4b0be"))
                                
                                Text("\(tweet.createdAt.toDate()!.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.english))")
                                    .foregroundColor(Color(hex: "57606f"))
                            }
                        }
                       Spacer()
                    }
                    .padding([.horizontal, .bottom],5)
                    .font(.caption)
                }
                .background(Color.init(hex: "f5f6fa"))
                
             }
         }.background(Color.white).cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
    }
}
extension TwitterFeed{
    func loadData() -> Void {
        loadingData = true
        TwitterClient.api.search(for: symbol, completionHandler: {list in
            guard let tweets = list?.data else{
                loadingData = false
                return
            }
            
            guard let includes = list?.includes?.users else{
                loadingData = false
                return
            }
            
            loadingData = false
            includedUserData = includes
            feed = tweets
        })
    }
}
//struct TwitterFeed_Previews: PreviewProvider {
//    static var previews: some View {
//        TwitterFeed(symbol: .constant("AAPL"),feed: testTweets).background(Color.gray)
//    }
//
//    static var testTweets = [
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "this is a great stock"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "Stocks are fun to trade"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "im trading stocks using stocktile"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "fjdosai oi oi i opij oioiuoihjoi ouhgiygiygiy giyugiygyguygiyh"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "dsiuad iuhiughi iuhiuhluhluhliuh uhiujbiuiyugiy hiuhiuiyg8ytfytvuiu iuygi giug iug iu i ugiygiygiuygiu"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "ds8ds9a oiu houi hiy g  guyguyuh9u7 87h9uih 9u g87 g89u h9u g87 g988ytedrdtrfu hiugiyguyg iu. HIUhiyuguyg ygtyu tgutyfu tfu tf t ui hofisdahoisuhaodiusghao houih ouhfosua hdou hgiouhgiughiygftf hgiudgsaidygsi a."),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "using @StockTile"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "HIUhiyuguyg ygtyu tgutyfu tfu tf t ui hofisdahoisuhaodiusghao houih ouhfosua hdou hgiouhgiughiygftf hgiudgsaidygsi a.. using @StockTile"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "using @StockTile"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "using @StockTile"),
//        Tweet(authorID: "321321", createdAt: "4 hours ago", entities: nil, tweet_id: "8fsyda9d8h00", lang: "English", possiblySensitive: true, referencedTweets: nil, source: "Twitter for iphone", text: "HIUhiyuguyg ygtyu tgutyfu tfu tf t ui hofisdahoisuhaodiusghao houih ouhfosua hdou hgiouhgiughiygftf hgiudgsaidygsi a."),
//
//    ]
//}
