//
//  SectorMap.swift
//  StockBox
//
//  Created by Darien Sandifer on 3/4/21.
//

import SwiftUI
import ExyteGrid

struct SectorMap: View {
//    @ObservedObject var manager = StockManager()
    
    var body: some View {
        Color.red
//        Grid(tracks: [.fr(1), .pt(150), .fr(2)]) {
//            ForEach(manager.marketSectors, id: \.id){ sector in
//                ZStack(alignment: .topTrailing){
//                    Color.blue
//                        .aspectRatio(contentMode: .fill)
//                        .cornerRadius(5)
//                        .frame(minWidth: 100, maxHeight: 550)
//                    Text(sector.sector!)
//                        .fontWeight(.heavy)
//                        .foregroundColor(.black)
//                        .padding()
//
//                }
//            }
//            Color.pink
//                .gridSpan(row: 2)
//            ZStack(alignment: .topTrailing){
//                Color.blue
//                Text("Industry")
//                    .fontWeight(.heavy)
//                    .foregroundColor(.black)
//                    .padding()
//            }.gridSpan(column: 3, row: 3)
//            ZStack(alignment: .topTrailing){
//                Color.blue
//                Text("Industry")
//                    .fontWeight(.heavy)
//                    .foregroundColor(.black)
//                    .padding()
//
//            }.gridSpan(column: 2, row: 4)
//            Color.purple
//                .gridSpan(row: 2)
//            Color.red.gridSpan(row: 5)
//            Color.black.gridSpan(column: 2)
//            Color.green
//                .gridSpan(column: 3, row: 3)
//            Color.orange.gridSpan(column: 1, row: 2)
//            Color.orange
//                .gridSpan(column: 2, row: 3)
//            Color.red.gridSpan(row: 3)
//        }.gridPacking(.dense)
//        .gridContentMode(.fill)
//        .onAppear(perform: {
//            manager.getSectors()
//        })
    }
}

struct SectorMap_Previews: PreviewProvider {
    static var previews: some View {
        SectorMap()
    }
}
