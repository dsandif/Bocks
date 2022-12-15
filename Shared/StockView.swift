//
//  StockView.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import SwiftUI
//import AVFoundation
import Haptica
import Peep
//import SwiftUICharts
import SwiftDate
import Charts

struct StockView: View {
    let screenPadding: CGFloat = 40.0
    @ObservedObject var vm: StockViewVm
    
    init(quote: Quote, marketHours: MarketHours) {
        vm = StockViewVm(stockQuote: quote, marketHours: marketHours)
    }
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .trailing, spacing: 10){
                Spacer()
                TickerView(quote: $vm.quote)
                LineChart().frame(minHeight: 500, alignment: .center)
                TickerHistory(quote: $vm.quote)
                
                Spacer()

                Carousel(items: [
                    CarouselItem(content: AnyView(CompanyDescription(vm: vm))),
                    CarouselItem(content: AnyView(TwitterFeed(symbol: $vm.quote.symbol, priceType: vm.quote.tileBackground))),
//                    CarouselItem(content:
//                        AnyView(
//                            HStack(alignment: .top){
//                                ///Make headlines section scrollable
//                                Headlines(news: vm.$news, symbol: $vm.quote.symbol, priceType: $vm.quote)
//                            }
//                        ))
                    ]
                )
            }
            .foregroundColor(AppColors.white)
        }
        .onAppear(perform: {
            vm.loadData()
        })
        .background(vm.quote.tileBackground.color.edgesIgnoringSafeArea(.all))
        .navigationBarColor(UIColor(vm.quote.tileBackground.color))
        .navigationBarItems(trailing:
            Button(action: {
                vm.updateAnimationAmount(newValue: vm.animationAmount + 1)
                Haptic.play("..oO-Oo..", delay: 0)
//                Peep.play(sound: AlertTone.complete)
//                Peep.play(sound: AlertTone.chime)
                vm.favorite = !vm.favorite
            }) {
                if(vm.favorite){
                    Image(systemName: "star.fill")
                        .foregroundColor(vm.quote.tileBackground.color)
                        .font(.title3)
                        .onAppear(perform: {
                            vm.updateAnimationAmount(newValue: 1)
                        })
                }else{
                    Image(systemName: "star")
                        .foregroundColor(.white)
                        .font(.title3)
                        .onAppear(perform: {
                            vm.updateAnimationAmount(newValue: 1)
                            vm.favorite = false
                        })
                }
            }
            .overlay(
                Image(systemName: "star")
                    .font(.title3)
                    .foregroundColor(vm.favorite ? vm.quote.tileBackground.color : .white )
                    .scaleEffect(vm.animationAmount)
                    .opacity(Double(2 - vm.animationAmount))
                    .animation(
                        Animation.easeOut(duration: 1)
                    )
            )
            .foregroundColor(vm.quote.tileBackground.color)

        )
    }
}

//extension StockView{
////    func speak() -> Void {
////        let utterance = AVSpeechUtterance(string: "Hello world")
////        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
////        utterance.rate = 0.1
////
////        let synthesizer = AVSpeechSynthesizer()
////        synthesizer.speak(utterance)
////    }
//
//    func getdataPoints() -> [ChartDataEntry] {
//        return prices.enumerated().map { (index, element: ChartPrice) in
//            return ChartDataEntry(x: Double(index), y: element.close)
//        }
//    }
//
//}


struct StockView_Previews: PreviewProvider {
    static var q: Quote{
        var t = Quote()
        t.symbol = "AAPL"
        t.name = "Apple Inc."
        t.price = 121.26000000
        t.changesPercentage = 0.22000000
        t.change = 0.27000000
        t.dayLow = 121.20000000
        t.dayHigh = 124.85000000
        t.yearHigh = 145.09000000
        t.yearLow = 53.15250000
        t.marketCap = 2035725107200.00000000
        t.priceAvg50 = 132.61353000
        t.priceAvg200 = 122.74868000
        t.volume = 164560045
        t.avgVolume = 106614683
        t.exchange = "NASDAQ"
        t.open = 122.59000000
        t.previousClose = 120.99000000
        t.eps = 3.68700000
        t.pe = 32.88852700
        t.earningsAnnouncement = "2021-01-27T16:30:00.000+0000"
        t.sharesOutstanding = 16788100835
        t.timestamp = 161446793
        return t
    }
    
    static var cp: CompanyProfile{
        var pro = CompanyProfile()
//        pro.symbol = "AAPL"
//        pro.price = 121.26
//        pro.beta = 1.33758
//        pro.volAvg = 106614683
//        pro.mktCap = 2035725110000
//        pro.lastDiv = 0.82
//        pro.range = "53.1525-145.09"
//        pro.changes = 0.27
//        pro.companyName = "Apple Inc"
//        pro.currency = "USD"
//        pro.cik = "0000320193"
//        pro.isin = "US0378331005"
//        pro.cusip = "037833100"
//        pro.exchange = "Nasdaq Global Select"
//        pro.exchangeShortName = "NASDAQ"
//        pro.industry = "Consumer Electronics"
//        pro.website = "https://www.apple.com/"
//        pro.description = "Apple Inc. designs, manufactures, and markets smartphones, personal computers, tablets, wearables, and accessories worldwide. It also sells various related services. The company offers iPhone, a line of smartphones; Mac, a line of personal computers; iPad, a line of multi-purpose tablets; and wearables, home, and accessories comprising AirPods, Apple TV, Apple Watch, Beats products, HomePod, iPod touch, and other Apple-branded and third-party accessories. It also provides AppleCare support services; cloud services store services; and operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games, and podcasts. In addition, the company offers various services, such as Apple Arcade, a game subscription service; Apple Music, which offers users a curated listening experience with on-demand radio stations; Apple News+, a subscription news and magazine service; Apple TV+, which offers exclusive original content; Apple Card, a co-branded credit card; and Apple Pay, a cashless payment service, as well as licenses its intellectual property. The company serves consumers, and small and mid-sized businesses; and the education, enterprise, and government markets. It sells and delivers third-party applications for its products through the App Store. The company also sells its products through its retail and online stores, and direct sales force; and third-party cellular network carriers, wholesalers, retailers, and resellers. Apple Inc. was founded in 1977 and is headquartered in Cupertino, California."
//        pro.ceo = "Mr. Timothy Cook"
//        pro.sector = "Technology"
//        pro.country = "US"
//        pro.fullTimeEmployees = "147000"
//        pro.phone = "14089961010"
//        pro.address = "1 Apple Park Way"
//        pro.city = "Cupertino"
//        pro.state = "CALIFORNIA"
//        pro.zip = "95014"
//        pro.dcfDiff = 89.92
//        pro.dcf = 127.377
//        pro.image = "https://financialmodelingprep.com/image-stock/AAPL.png"
//        pro.ipoDate = "1980-12-12"
//        pro.defaultImage = false
//        pro.isEtf = false
//        pro.isActivelyTrading = true
        return pro
    }

    static var previews: some View {
        Text("Test")
//        StockView(quote: .constant(StockView_Previews.q), companyInfo: StockView_Previews.cp.description)
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: .infinity, maxHeight: .infinity)
//            .edgesIgnoringSafeArea(.all)

    }
}
