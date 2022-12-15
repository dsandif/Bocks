//
//  Tile.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/26/21.
//

import SwiftUI

struct Tile: View {
    var symbol: String = ""
    var value: Float = 0.0
    var tileBackground: PriceType {
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
    
    var favorite: Bool = false
    
    init(ticker: String, percent: Float, shadow: Bool) {
        symbol = ticker
        value = percent
        favorite = shadow
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5, style: .continuous)
            .stroke(tileBackground.color, lineWidth: 4)
            .scaledToFit()
            .overlay(
                VStack(alignment: .center){
                    Text("\(symbol)".uppercased())
                        .fontWeight(.heavy)
                        .font(.caption)
                    Text("\(String(format: "%.1f", value))%")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundColor(AppColors.white)
                    
                }
            )
            .foregroundColor(tileBackground.color)
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(ticker: "msft", percent: -22.0, shadow: false)
            .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color("Neutral"))
    }
}


enum PriceType: String, CaseIterable {
    ///icons
    case negativeHigh
    case negativeMid
    case negativeLow
    case positiveHigh
    case positiveMid
    case positiveLow
    case even
    
    var color: Color {
        switch self {
        case .negativeHigh:
            return Color("Negative1")
        case .negativeMid:
            return Color("Negative2")
        case .negativeLow:
            return Color("Negative3")
        case .positiveLow:
            return Color("Positive1")
        case .positiveMid:
            return Color("Positive2")
        case .positiveHigh:
            return Color("Positive3")
        case .even:
            return Color("Yellow")
        }
    }
    
    func toHex() -> String{
        return "#" + UIColor(self.color).toHex()!
    }
    
    func darkerChartColor() -> String {
        let color = UIColor(self.color).add(overlay: UIColor(white: 0, alpha: 0.3))
        return "#" + color.toHex()!
    }
}

extension PriceType: Identifiable {
    var id: String { rawValue }
}
