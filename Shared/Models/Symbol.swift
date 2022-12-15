//
//  Symbol.swift
//  StockBox
//
//  Created by Darien Sandifer on 3/3/21.
//
import Foundation

// MARK: - SymbolElement
struct Symbol: Codable {
    let symbol: String?
    let companyName: String?
    let marketCap: Double?
    let sector: Sector?
    let industry: String?
    let beta: Double?
    let price: Double?
    let lastAnnualDividend: Double?
    let volume: Int?
    let exchange: Exchange?
    let exchangeShortName: ExchangeShortName?
    let country: String?
    let isEtf: Bool?
    let isActivelyTrading: Bool?

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case companyName = "companyName"
        case marketCap = "marketCap"
        case sector = "sector"
        case industry = "industry"
        case beta = "beta"
        case price = "price"
        case lastAnnualDividend = "lastAnnualDividend"
        case volume = "volume"
        case exchange = "exchange"
        case exchangeShortName = "exchangeShortName"
        case country = "country"
        case isEtf = "isEtf"
        case isActivelyTrading = "isActivelyTrading"
    }
}

enum Exchange: String, Codable {
    case batsExchange = "BATS Exchange"
    case empty = ""
    case exchangeNyseArca = "NYSEArca"
    case nasdaqCapitalMarket = "NASDAQ Capital Market"
    case nasdaqGlobalMarket = "NASDAQ Global Market"
    case nasdaqGlobalSelect = "NASDAQ Global Select"
    case nasdaq = "Nasdaq"
    case newYorkStockExchange = "New York Stock Exchange"
    case nms = "NMS"
    case nyseArca = "NYSE Arca"
    case swiss = "Swiss"
}

enum ExchangeShortName: String, Codable {
    case nasdaq = "NASDAQ"
    case nyse = "NYSE"
}

enum Sector: String, Codable {
    case basicMaterials = "Basic Materials"
    case communicationServices = "Communication Services"
    case consumerCyclical = "Consumer Cyclical"
    case consumerDefensive = "Consumer Defensive"
    case empty = ""
    case energy = "Energy"
    case financialServices = "Financial Services"
    case healthcare = "Healthcare"
    case industrials = "Industrials"
    case realEstate = "Real Estate"
    case technology = "Technology"
    case utilities = "Utilities"
}

typealias SymbolList = [Symbol]
