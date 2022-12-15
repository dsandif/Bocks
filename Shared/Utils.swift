//
//  Utils.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import Foundation

func showPolarity(newDouble: Float, digitsAfterDeci: Int = 2, asIcon: Bool = false) -> String{
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.positivePrefix = asIcon ? "▲ " : "+"
    numberFormatter.negativePrefix = asIcon ? "▼ " : "-"
    numberFormatter.maximumFractionDigits = digitsAfterDeci
//        String(format: "%.3f", newDouble)
    let formattedDouble = numberFormatter.string(for: newDouble)
    return formattedDouble ?? ""
}
func currency(value: Double) -> String {
    return String(format: "%.2f", value)
}
