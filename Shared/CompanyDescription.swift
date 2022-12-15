//
//  CompanyDescription.swift
//  StockTile
//
//  Created by Darien Sandifer on 2/28/21.
//

import SwiftUI

struct CompanyDescription: View {
    @ObservedObject var vm: StockViewVm
    
    var body: some View {

        VStack(alignment: .trailing){
            HStack{
                Image(systemName: "building.2.fill")
                Text("About")
                    .fontWeight(.heavy)
            }
            Divider().frame(height:2).background(Color.white)
            ZStack{
                RoundedRectangle(cornerRadius: 3.0)
                    .fill(Color(UIColor.init(vm.quote.tileBackground.color).add(overlay: UIColor(white: 0, alpha: 0.1))))
                ScrollView(.vertical, showsIndicators: false){
                    Text("\(vm.companyInfo)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .lineSpacing(3.0)
                        .padding()
                }
            }
        }
    }
}

struct CompanyDescription_Previews: PreviewProvider {
    static var previews: some View {
        Text("not implemented")
//        CompanyDescription(companyInfo: StockView_Previews.cp.description, quote: StockView_Previews.q)
    }
}
