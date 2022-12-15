//
//  StockViewVm.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/21/21.
//

import Foundation
import SwiftUI
import SwiftDate



    class StockViewVm: ObservableObject {
        private let service = StockManager()
        let screenPadding: CGFloat = 40.0
        var quote: Quote
        var marketTimes: MarketHours
        
        @Published var news: NewsList = []
        @Published var companyInfo: String = ""
        @Published var prices: ChartPrices = []
        @Environment(\.horizontalSizeClass) var sizeClass
        @Published private(set) var animationAmount: CGFloat = 1
        @State var favorite: Bool = false

        
        init(stockQuote: Quote, marketHours: MarketHours) {
            quote = stockQuote
            marketTimes = marketHours
        }
        
        func loadData() -> Void {
            loadNews()
            loadChartPrices()
            loadCompanyProfile()
        }
        
        
        private func loadNews() {
            service.getNews(for: quote.symbol, completionHandler: { items in
                self.news = items
            })
        }
        
        func updateAnimationAmount(newValue: CGFloat ) {
            self.animationAmount = newValue
        }
        
        private func loadCompanyProfile(){
            service.getcompanyProfile(for: quote.symbol) { profile in
                guard let description = profile?.description else {
                    self.companyInfo = ""
                    return
                }
                    
                self.companyInfo = description
            }
        }
        
        private func loadChartPrices(){
            service.getChartPrices(for: quote.symbol) { items in
                let nyRegion = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
                let now = Date().in(region: nyRegion)

                let openingTime = now.dateBySet(hour: 9, min: 30, secs: 01) // 9:30 am
                let closingTime = now.dateBySet(hour: 16, min: 00, secs: 01) //4 pm

                let openingDateTime = DateInRegion(components: {
                        $0.year = now.dateComponents.year
                        $0.month = now.dateComponents.month
                        $0.day = now.dateComponents.day
                        $0.hour = openingTime?.hour
                        $0.minute = openingTime?.minute
                        $0.second = openingTime?.second
                }, region: nyRegion)

                let closingDateTime = DateInRegion(components: {
                        $0.year = now.dateComponents.year
                        $0.month = now.dateComponents.month
                        $0.day = now.dateComponents.day
                        $0.hour = closingTime?.hour
                        $0.minute = closingTime?.minute
                        $0.second = closingTime?.second
                }, region: nyRegion)

                let apiDateFormat = "yy-mm-dd hh:mm:ss"
                let format = "hh:mm"
                    
                let range = openingDateTime! - 1.days...closingDateTime! - 1.days


                DispatchQueue.global(qos: .userInteractive).async {

                    let filteredItems = items.filter({ (price: ChartPrice) -> Bool in
                        return (range.contains(price.getDate()) == true)
                    })

                    DispatchQueue.main.async {
                        self.prices = filteredItems
                        print(filteredItems)
                    }

                }
            }

        }
    }
