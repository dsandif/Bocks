//
//  Headlines.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import SwiftUI

struct Headlines: View {
    @Binding var news: [CompanyNews]
    @State var idx = 0
    @Binding var symbol: String
    @Binding var priceType: PriceType
    @Environment(\.horizontalSizeClass) var sizeClass
    var gridItems: [GridItem] = [GridItem(.adaptive(minimum: 250, maximum: 250)), GridItem(.adaptive(minimum: 250, maximum: 250)), GridItem(.adaptive(minimum: 250, maximum: 250))]
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Image(systemName: "newspaper.fill")
                Text("Headlines")
                    .fontWeight(.heavy)
            }
            
            Divider().frame(height:2).background(AppColors.white)
            
            ScrollView(.vertical, showsIndicators: false){
                if(sizeClass == .compact){
                    smallView
                }else{
                    gridView
                }
            }
        }
    }
    
    var gridView: some View{
        LazyVGrid(columns: gridItems, alignment: .center, spacing: 20) {
            ForEach(news, id: \.id){ line in
                    NewsView(header: line.stringDate(), title: line.title, caption: line.text, imageURL: line.image, source: line.url)
                        .frame(height: 300)
            }
        }
    }
    
    
    var smallView: some View{
        ForEach(news, id: \.id){ line in
            VStack(alignment: .leading, spacing: 2){
                NewsView(header: line.stringDate(), title: line.title, caption: line.text, imageURL: line.image, source: line.url)
            }
            .onReceive(timer) { input in
                //Todo: Setup timer to autoscroll headlines
            }
            Spacer(minLength: 25)
        }
    }
}


struct Headlines_Previews: PreviewProvider {
    static var compNews: [CompanyNews]{
        var list:[CompanyNews] = []
        var n = CompanyNews()
        n.symbol = "AAPL"
        n.publishedDate = "2021-02-27 17:55:41"
        n.title = "YouTube's New Streaming Push Rivals Apple, Spotify"
        n.image = "https://cdn.snapi.dev/images/v1/v/z/shutterstock-210089881-5bfc309cc9e77c005877faaa-699771.jpg"
        n.site = "Investopedia"
        n.text = "As part of an initiative to double down on subscription services, Alphabet has revamped YouTube Red."
        n.url = "https://www.investopedia.com/news/youtubes-new-streaming-push-rivals-apple-spotify/"
        
        for _ in (0...40){
            list.append(n)
        }
        return list
    }
    
    static var previews: some View {
        Text("not implemented - needs pricetype added")
//        Headlines(symbol: .constant("AAPL"))
    }
}


//TabView(){
//        Headlines(news: $news, symbol: $quote.symbol, priceType: .constant(quote.tileBackground)).edgesIgnoringSafeArea(.all)
//        CompanyDescription(companyInfo: companyInfo).edgesIgnoringSafeArea(.all)
//            .padding(.all, 30)
//        TwitterFeed(symbol: $quote.symbol).edgesIgnoringSafeArea(.all)
//    }
//    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500)
//    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
