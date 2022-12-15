//
//  MarketHours.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/16/21.
//

import Foundation

// MARK: - MarketHour
struct MarketHour: Codable {
    let stockExchangeName: String?
    let stockMarketHours: StockMarketHours?
    let stockMarketHolidays: [StockMarketHoliday]?
    let isTheStockMarketOpen: Bool?
    let isTheEuronextMarketOpen: Bool?
    let isTheForexMarketOpen: Bool?
    let isTheCryptoMarketOpen: Bool?

    enum CodingKeys: String, CodingKey {
        case stockExchangeName = "stockExchangeName"
        case stockMarketHours = "stockMarketHours"
        case stockMarketHolidays = "stockMarketHolidays"
        case isTheStockMarketOpen = "isTheStockMarketOpen"
        case isTheEuronextMarketOpen = "isTheEuronextMarketOpen"
        case isTheForexMarketOpen = "isTheForexMarketOpen"
        case isTheCryptoMarketOpen = "isTheCryptoMarketOpen"
    }
}

// MARK: - StockMarketHoliday
struct StockMarketHoliday: Codable {
    let year: Int?
    let newYearsDay: String?
    let martinLutherKingJrDay: String?
    let washingtonSBirthday: String?
    let goodFriday: String?
    let memorialDay: String?
    let independenceDay: String?
    let laborDay: String?
    let thanksgivingDay: String?
    let christmas: String?

    enum CodingKeys: String, CodingKey {
        case year = "year"
        case newYearsDay = "New Years Day"
        case martinLutherKingJrDay = "Martin Luther King, Jr. Day"
        case washingtonSBirthday = "Washington's Birthday"
        case goodFriday = "Good Friday"
        case memorialDay = "Memorial Day"
        case independenceDay = "Independence Day"
        case laborDay = "Labor Day"
        case thanksgivingDay = "Thanksgiving Day"
        case christmas = "Christmas"
    }
}

// MARK: - StockMarketHours
struct StockMarketHours: Codable {
    let openingHour: String?
    let closingHour: String?

    enum CodingKeys: String, CodingKey {
        case openingHour = "openingHour"
        case closingHour = "closingHour"
    }
}

typealias MarketHours = [MarketHour]
