//
//  Quote.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import Foundation
import Haptica
// MARK: - Quote
struct Quote: Codable {
    let id = UUID()
    var symbol = "", name: String? = ""
    var price: Double? = 0.0, changesPercentage: Float? = 0.0, change: Float? = 0.0, dayLow: Double? = 0.0
    var dayHigh: Double? = 0.0, yearHigh: Double? = 0.0, yearLow: Double? = 0.0, marketCap: Double? = 0.0
    var priceAvg50: Double? = 0.0, priceAvg200: Double? = 0.0
    var volume: Int? = 0, avgVolume: Int? = 0
    var exchange: String = ""
    var open: Double? = 0.0, previousClose: Double? = 0.0, eps: Double? = 0.0, pe: Double? = 0.0
    var earningsAnnouncement: String? = ""
    var sharesOutstanding: Int? = 0, timestamp: Int = 0
    
    var tileBackground: PriceType {
        guard let value = self.changesPercentage else { return .even }
        
        if(value >= 1 && value < 2){
            return .positiveLow
        }else if (value >= 2 && value < 3) {
            return .positiveMid
        }else if (value >= 3) {
            return .positiveHigh
        }else if(value <= -1 && value > -2){
            return .negativeLow
        }else if (value <= -2 && value > -3) {
            return .negativeMid
        }else if (value <= -3) {
            return .negativeHigh
        }else{
            return .even
        }
    }
    
    private var hapticNote: HapticFeedbackStyle? {
        guard let value = self.changesPercentage else { return nil }
        
        if(value >= 1 && value < 2){
            return .light
        }else if (value >= 2 && value < 3) {
            return .medium
        }else if (value >= 3) {
            return .heavy
        }else if(value <= -1 && value > -2){
            return .light
        }else if (value <= -2 && value > -3) {
            return .medium
        }else if (value <= -3) {
            return .heavy
        }
        
        return nil
    }
    
    
    func priceAcessibility() -> Void {
        guard let note = hapticNote else { return }
        Haptic.impact(note)
    }
}

typealias QuoteList = [Quote]
