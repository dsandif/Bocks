//import SwiftUI
//import SwiftUICharts
//import SwiftDate
//
//struct LineChartDemoView: View {
//    var data : LineChartData
//    
//    var body: some View {
//        VStack {
//            LineChart(chartData: data)
//                .pointMarkers(chartData: data)
//                .touchOverlay(chartData: data, specifier: "%.0f")
//                .yAxisPOI(chartData: data,
//                          markerName: "Step Count Aim",
//                          markerValue: 15_000,
//                          labelPosition: .center(specifier: "%.0f"),
//                          labelColour: Color.black,
//                          labelBackground: Color(red: 1.0, green: 0.75, blue: 0.25),
//                          lineColour: Color(red: 1.0, green: 0.75, blue: 0.25),
//                          strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
//                .yAxisPOI(chartData: data,
//                          markerName: "Minimum Recommended",
//                          markerValue: 10_000,
//                          labelPosition: .center(specifier: "%.0f"),
//                          labelColour: Color.white,
//                          labelBackground: Color(red: 0.25, green: 0.75, blue: 1.0),
//                          lineColour: Color(red: 0.25, green: 0.75, blue: 1.0),
//                          strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
//                .averageLine(chartData: data,
//                             strokeStyle: StrokeStyle(lineWidth: 3, dash: [5,10]))
//                .xAxisGrid(chartData: data)
//                .yAxisGrid(chartData: data)
//                .xAxisLabels(chartData: data)
//                .yAxisLabels(chartData: data)
//                .infoBox(chartData: data)
//                .headerBox(chartData: data)
//                .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible())])
//                .id(data.id)
////                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
//                .frame(minWidth: 150, maxWidth: .infinity, minHeight: 500, maxHeight: .infinity, alignment: .center)
//                .padding(.horizontal)
//        }
////        .navigationTitle("Week of Data")
//    }
//}
////
////struct LineChartView_Previews: PreviewProvider {
////    static var previews: some View {
////        LineChartDemoView(prices: .constant([]))
////    }
////}
//
//extension Color {
//    
//    public static var myBackground: Color {
//        #if os(iOS)
//        return Color(.systemBackground)
//        #elseif os(tvOS)
//        return Color(.darkGray)
//        #elseif os(macOS)
//        return Color(.windowBackgroundColor)
//        #endif
//    }
//    
//}
