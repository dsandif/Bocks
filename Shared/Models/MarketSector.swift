//
//  Sector.swift
//  StockBox
//
//  Created by Darien Sandifer on 3/4/21.
//

import Foundation

// MARK: - MarketSector
struct MarketSector: Codable {
    let id = UUID()
    let sector: String?
    let changesPercentage: String?

    enum CodingKeys: String, CodingKey {
        case sector = "sector"
        case changesPercentage = "changesPercentage"
    }
}

typealias SectorList = [MarketSector]
