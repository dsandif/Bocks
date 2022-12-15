//
//  TickerView.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import SwiftUI

struct TickerView: View {
    @Binding var quote: Quote
    
    var body: some View {
        HStack(alignment: .top){
            Spacer()
            VStack(alignment: .leading){
                Text(quote.symbol ?? "")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                Text(quote.name ?? "")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(UIColor.init(quote.tileBackground.color).add(overlay: UIColor(white: 0, alpha: 0.7))))
            }.padding(.trailing, 30)

            VStack(alignment: .trailing){
                Text("$\(currency(value: quote.price ?? 0.0 ))")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                Text("Todays Change")
                    .font(.caption2)
                    .fontWeight(.semibold)

                HStack{
                    Text("\(showPolarity(newDouble: quote.change ?? 0.0, asIcon: true ))")
                        .bold()
                    Text("(\(showPolarity(newDouble: quote.changesPercentage ?? 0.0 ))%)")
                        .bold()
                }
                .font(.body)
            }.font(.subheadline)
        }.padding(.horizontal,15)
    }
}

struct TickerView_Previews: PreviewProvider {
    static var previews: some View {
        TickerView(quote: .constant(StockView_Previews.q))
    }
}
