//
//  TestViewChart.swift
//  StockBox (iOS)
//
//  Created by Darien Sandifer on 3/11/21.
//

//import Foundation
//import SwiftUI
//import AAInfographics
//import SwiftDate
//import Haptica
//
//struct ChartSwiftUIView: UIViewRepresentable {
//    @Binding var prices: ChartPrices
//    @Binding var priceType: PriceType
//    @State var loaded: Bool = false
//    var aaChartView = AAChartView()
//    var aaChartModel = AAChartModel()
//        .chartType(.line)//Can be any of the chart types listed under `AAChartType`.
//        .animationType(.bounce)
//        .title("")//The chart title
//        .subtitle("")//The chart subtitle
//        .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
//        .tooltipValueSuffix(" USD")//the value suffix of the chart tooltip
//        .axesTextColor("#ffffff")
//    
//    var lineColor: String {
//        return (priceType == PriceType.even) ? "#a87c00" : "#ffc069"
//    }
//    
//    func updateUIView(_ uiView: AAChartView, context: Context) {
//        aaChartModel
//            .categories(
//                prices.compactMap({ (price: ChartPrice) -> String? in
//                    let currDate = price.date?.toDate()
//                    return (currDate?.toFormat("hh:mm aa").lowercased())!
//                })
//            )
//            .colorsTheme([priceType.darkerChartColor()])
//            .backgroundColor(priceType.toHex())
//            .series([
//                AASeriesElement()
//                    .name("")
//                    .data(prices.compactMap({ (price: ChartPrice) -> Double in
//                        return price.close
//                    }))
//            ])
//        
//        uiView.aa_refreshChartWholeContentWithChartModel(aaChartModel)
//    }
//        
//    func makeUIView(context: Context) -> AAChartView {
//        aaChartView.aa_drawChartWithChartModel(aaChartModel)
//        return aaChartView
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(prices: $prices)
//    }
//     
//    class Coordinator: NSObject {
//        var prices: Binding<ChartPrices>
//     
//        init(prices: Binding<ChartPrices>) {
//            self.prices = prices
//        }
//    }
//}
