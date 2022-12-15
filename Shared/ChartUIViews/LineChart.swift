//
//  LineChart.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/18/21.
//

import Foundation
import Charts
import SwiftUI

struct LineChart: UIViewRepresentable {
        let lineChart = LineChartView()

        func makeUIView(context: UIViewRepresentableContext<LineChart>) -> LineChartView {
            print("called")
            setUpChart()
            return lineChart
        }

        func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChart>) {
            print("updateUIview called")
        }

        func setUpChart() {
            lineChart.noDataText = "No Data Available"
            let dataSets = [getLineChartDataSet()]
            let data = LineChartData(dataSets: dataSets)
            data.setValueFont(.systemFont(ofSize: 7, weight: .light))
            lineChart.data = data
        }

        func getChartDataPoints(sessions: [Int], accuracy: [Double]) -> [ChartDataEntry] {
            var dataPoints: [ChartDataEntry] = []
            for count in (0..<sessions.count) {
                dataPoints.append(ChartDataEntry.init(x: Double(sessions[count]), y: accuracy[count]))
            }
            return dataPoints
        }

        func getLineChartDataSet() -> LineChartDataSet {
            let dataPoints = getChartDataPoints(sessions: [0,1,2], accuracy: [100.0, 20.0, 30.0])
            let set = LineChartDataSet(entries: dataPoints, label: "DataSet")
            set.lineWidth = 2.5
            set.circleRadius = 4
            set.circleHoleRadius = 2
            let color = ChartColorTemplates.vordiplom()[0]
            set.setColor(color)
            set.setCircleColor(color)
            return set
        }
}
