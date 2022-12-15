//
//  ChartPrice.swift
//  StockBox (iOS)
//
//  Created by Darien Sandifer on 3/13/21.
//

import Foundation
import SwiftDate

// MARK: - ChartPrice
struct ChartPrice: Codable, Identifiable {
    let id = UUID()
    private let date: String
    let chartPriceOpen: Double?
    let low: Double?
    let high: Double?
    let close: Double
    let volume: Int?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case chartPriceOpen = "open"
        case low = "low"
        case high = "high"
        case close = "close"
        case volume = "volume"
    }
    
    func getDate() -> DateInRegion{
        let nyRegion = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
        let priceDate = Date(date)!.in(region: nyRegion)
        return priceDate
    }
}

typealias ChartPrices = [ChartPrice]
