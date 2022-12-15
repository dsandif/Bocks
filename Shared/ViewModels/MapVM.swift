//
//  MapVM.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/21/21.
//

import Foundation

extension Map {

    class MapVM: ObservableObject {
        private let service = StockManager()
        @Published private(set) var quotes: QuoteList = []
        @Published private(set) var headlines: String = ""
        @Published private(set) var marketHours: MarketHours = []
        
        init() {
            loadQuoteMap()
            getMarketHours()
            loadHeadlines()
        }
        
        func loadQuoteMap() {
            service.getSymbols({ quotes in
                self.quotes = quotes
            })
        }
        
        func loadHeadlines() {
            service.getMainNews({ news in
                self.headlines = news
            })
        }
        
        func getMarketHours() {
            service.getMarketHours({ items in
                self.marketHours = items
            })
        }
    }
}
