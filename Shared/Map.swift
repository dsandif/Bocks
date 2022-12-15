//
//  Map.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/26/21.
//

import SwiftUI
//import ExyteGrid
import Marquee
import Haptica
import Peep

fileprivate let scrollDuration = 1000.0

struct Map: View {
    @ObservedObject var vm = MapVM()
    let timer = Timer.publish(every: TimeInterval(scrollDuration), on: .main, in: .common).autoconnect()
    var rows: [GridItem] =
        [.init(.adaptive(minimum: 50, maximum: 100))]
    
    var body: some View {
        NavigationView{
            VStack{
    //            Grid(tracks: 13, flow: .rows, spacing: 0) {
    //                ForEach(stockManager.quotes, id: \.id){ stock in
    //                    Tile(ticker: stock.symbol, percent: Float(stock.change ?? 0.0 ), shadow: false)
    //                }
    //            }
    //            .gridContentMode(.scroll)
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: rows) {
                        ForEach(vm.quotes, id: \.id){ stock in
                            NavigationLink(destination: StockView(quote: stock, marketHours: vm.marketHours)){
                                Tile(ticker: stock.symbol, percent: Float(stock.changesPercentage ?? 0.0 ), shadow: false)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                Haptic.play("..oO-Oo..", delay: 0)
                                Peep.play(sound: KeyPress.tap)
                            })
                        }
                    }
                    .padding([.leading,.trailing], 5)
                    .padding([.top, .bottom], 10)
                    .id(UUID())
                }
                
                Marquee{
                    VStack(alignment: .leading){
                        Text(vm.headlines)
                            .fontWeight(.bold)
                            .font(.caption)
                    }
                }
                .marqueeDuration(scrollDuration)
                .foregroundColor(.white)
                .frame(maxHeight: 40)
                .padding(.bottom, -10)
                .padding(.top, -5)
                .edgesIgnoringSafeArea([.leading, . trailing])
            }
            .background(Color("Neutral").edgesIgnoringSafeArea(.all))
            .onReceive(timer, perform: { value in
                vm.loadHeadlines()
            })            
            .navigationBarItems(
                leading:
                    Image("BocksLogoTransparent")
                        .resizable()
                        .frame(width: 22, height: 22),
                trailing:
                    HStack{
                        Image(systemName: "list.star").foregroundColor(.white)
                        Image(systemName: "magnifyingglass.circle").foregroundColor(.white)
                    }.font(.title2)
            )
            .navigationBarTitle(Text(""))
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationBarColor(UIColor(Color("Neutral")))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map().padding().background(Color("Neutral"))
    }
}
