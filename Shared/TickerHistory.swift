//
//  TickerHistory.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/27/21.
//

import SwiftUI
import SwiftDate
struct TickerHistory: View {
    @Binding var quote: Quote
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Last updated: " + Date(timeIntervalSince1970: TimeInterval(quote.timestamp)).toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.english))
                    .fontWeight(.heavy)
            }
            .padding([.horizontal],15)
            .foregroundColor(Color(UIColor.init(quote.tileBackground.color).add(overlay: UIColor(white: 0, alpha: 0.4))))
            .font(.caption2)
            
            Divider().frame(height:1).background(AppColors.white)
            statView
                .font(.headline)
                .padding([.all],15)
                .background(Color(UIColor.init(quote.tileBackground.color).add(overlay: UIColor(white: 0, alpha: 0.1))))
        }
    }

    private var statView: some View{
        HStack{
            if(sizeClass == .compact){
                VStack(alignment: .leading, spacing: 20){
                    sectionA
                    sectionB
                }

            }else{
                HStack(alignment: VerticalAlignment.center, spacing: 100){
                    sectionAFlipped
//                    Divider().frame(width: 1).background(Color(UIColor.init(quote.tileBackground.color).add(overlay: UIColor(white: 0, alpha: 0.1))))
                    sectionB
                }
            }
        }
    }
    
    private var sectionA: some View{
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("Previous Close").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.previousClose ?? 0.0 ))")
            }

            HStack{
                Text("Open").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.open ?? 0.0 ))")
            }

            HStack{
                Text("Range").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.dayLow ?? 0.0 )) - \(currency(value: quote.dayHigh ?? 0.0 ))")
            }

            HStack{
                Text("52wk").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.yearLow ?? 0.0 )) - \(currency(value: quote.yearHigh ?? 0.0 ))")
            }
            HStack{
                Text("Exchange").fontWeight(.heavy)
                Spacer()
                Text("\(quote.exchange)")
            }
        }
    }
    
    private var sectionAFlipped: some View{
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("\(currency(value: quote.previousClose ?? 0.0 ))")
                Spacer()
                Text("Previous Close").fontWeight(.heavy)
                
            }

            HStack{
                Text("\(currency(value: quote.open ?? 0.0 ))")
                Spacer()
                Text("Open").fontWeight(.heavy)
            }

            HStack{
                Text("\(currency(value: quote.dayLow ?? 0.0 )) - \(currency(value: quote.dayHigh ?? 0.0 ))")
                Spacer()
                Text("Range").fontWeight(.heavy)
            }

            HStack{
                Text("\(currency(value: quote.yearLow ?? 0.0 )) - \(currency(value: quote.yearHigh ?? 0.0 ))")
                Spacer()
                Text("52wk").fontWeight(.heavy)
            }
            HStack{
                Text("\(quote.exchange)")
                Spacer()
                Text("Exchange").fontWeight(.heavy)
            }
        }
    }

    
    private var sectionB: some View{

        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text("Market Cap").fontWeight(.heavy)
                Spacer()
                Text("\(Int(quote.marketCap ?? 0))")
            }
            HStack{
                Text("Vol").fontWeight(.heavy)
                Spacer()
                Text("\(quote.avgVolume ?? 0)")
            }
            HStack{
                Text("Avg. Vol").fontWeight(.heavy)
                Spacer()
                Text("\(quote.avgVolume ?? 0 )")
            }
            HStack{
                Text("P/E").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.pe ?? 0))")
            }
            HStack{
                Text("EPS").fontWeight(.heavy)
                Spacer()
                Text("\(currency(value: quote.eps ?? 0.0))")
            }
        }
    }
}

struct TickerHistory_Previews: PreviewProvider {
    static var previews: some View {
        TickerHistory(quote: .constant(StockView_Previews.q))
            .frame(width: 350, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}
