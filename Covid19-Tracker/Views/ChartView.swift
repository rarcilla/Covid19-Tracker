////
////  ChartView.swift
////  Covid19-Tracker
////
////  Created by Regina Arcilla on 2020-05-21.
////  Copyright © 2020 Regina Arcilla. All rights reserved.
////
//
//import SwiftUI
//import Charts
//
//struct ChartView: View {
////    @Binding var chartData: [(Date, Int)]
//    @ObservedObject var api = Api()
//    
//    var body: some View {
//        VStack {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            CustomLineChartView(chartData: [(Date, Int)]())
//        }
//    }
//}
//
//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView()
//    }
//}
//
//struct CustomLineChartView: UIViewRepresentable {
////    @Binding var chartData: [(Date, Int)]
//    var chartData: [(Date, Int)]
//
//    
//    var lineChart = LineChartView()
//    
//    func makeUIView(context: Context) -> LineChartView {
//        setup()
//        return lineChart
//    }
//    
//    func updateUIView(_ uiView: LineChartView, context: Context) {
//    }
//    
//    func setup() {
//        
//        lineChart.noDataText = "No data provided at this time"
//        
//        let xAxis = lineChart.xAxis
//        xAxis.labelPosition = .topInside
//        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//        xAxis.drawAxisLineEnabled = false
//        xAxis.drawGridLinesEnabled = true
//        xAxis.centerAxisLabelsEnabled = true
//        xAxis.granularity = 3600
//        xAxis.valueFormatter = DateValueFormatter()
////
//        let leftAxis = lineChart.leftAxis
//        leftAxis.labelPosition = .insideChart
//        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
//        leftAxis.drawGridLinesEnabled = true
//        leftAxis.granularityEnabled = true
//        leftAxis.axisMinimum = 0
//        leftAxis.axisMaximum = 200000
//        leftAxis.yOffset = -9
//
//
//        let values = chartData.map { (tuple: (Date, Int)) -> ChartDataEntry in
//            let xValue = tuple.0 
//            let yValue = Double(tuple.1)
//
//            return ChartDataEntry(x: xValue, y: yValue)
//        }
//
////
////
//        let set1 = LineChartDataSet(entries: values)
////        set1.axisDependency = .left
////        set1.lineWidth = 1.5
////
//        let data = LineChartData(dataSet: set1)
//        lineChart.data = data
//    }
//    
//}

