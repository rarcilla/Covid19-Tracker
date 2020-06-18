//
//  ChartView.swift
//  Covid19-Tracker
//
//  Created by Regina Arcilla on 2020-05-21.
//  Copyright © 2020 Regina Arcilla. All rights reserved.
//

import SwiftUI


struct ChartView: View {
    var barValues: [(Date, Int)]

    var body: some View {
        VStack {
            if barValues.count > 0 {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(0..<barValues.count, id: \.self) { index in
                        BarView(date: self.barValues[index].0,
                                value: CGFloat(self.barValues[index].1),
                                maxValue: CGFloat(self.barValues.map{$0.1}.max() ?? 0))
                    }
                }
                .animation(.default)
            } else {
                VStack {
                    Spacer()
                    Text("Loading...")
                        .font(.title)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                .frame(height: 300)
            }
            
            Text("History Over the Last 7 Days")
                .font(.title)
        }
    }
}

//struct ChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChartView(barValues: [(Date(), 100), (Date(), 200), (Date(), 90)])
//    }
//}

struct BarView: View {
    var date: Date
    var height: CGFloat = 300
    var value: CGFloat
    var maxValue: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 30, height: 200).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 30, height: (value/maxValue)*200).foregroundColor(Color(red: 1.00, green: 0.27, blue: 0.31))
                    .overlay(BarValueLabel(value: value), alignment: .top)
            }
            .padding(.bottom, 5)
            BarDateLabel(date: date)
        }
    }
}

struct BarValueLabel: View {
    var value: CGFloat
    
    var body: some View {
        Text("\(Int(value))")
            .font(.footnote)
            .rotationEffect(.degrees(-90))
            .foregroundColor(.white)
        .padding(5)
    }
}

struct BarDateLabel: View {
    var date: Date
    
    var body: some View {
        Text(self.formatDate(date: self.date))
            .font(.footnote)
    }
    
    fileprivate func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter.string(from: date)
    }
}
