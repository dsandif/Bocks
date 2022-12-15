//
//  Cardview.swift
//  Bocks (iOS)
//
//  Created by Darien Sandifer on 3/17/21.
//

import SwiftUI

struct NewsView: View {
    var header: String = ""
    var title: String = ""
    var caption: String = ""
    var imageURL: String = ""
    var source: String = ""
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(url: URL(string: imageURL)!)
                .body
                .resizable()
                .scaledToFit()
            HStack {
                content
                Spacer()
            }
            .padding()
        }
        .cornerRadius(3)
        .overlay(RoundedRectangle(cornerRadius: 3)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .background(Color.white.cornerRadius(3))
//        .padding([.top, .horizontal])
    }
    
    var content: some View{
        Link(destination: URL(string: source.replacingOccurrences(of: "http://", with: "https://"))!) {
            if(sizeClass == .compact){
                VStack(alignment: .leading, spacing: 8) {
                    Text(header)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(title)
                        .font(.caption2)
                        .fontWeight(.black)
                        .foregroundColor(Color("Neutral"))
                        .lineLimit(3)
                    Text(caption)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .layoutPriority(100)
            }else{
                    VStack(alignment: .leading, spacing: 8) {
                        Text(header)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(title)
                            .font(.caption2)
                            .fontWeight(.black)
                            .foregroundColor(Color("Neutral"))
                            .lineLimit(3)
                        Text(caption)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                    .layoutPriority(100)
                
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(header: "Swiftui", title: "News Headline", caption: "faiou hiu uiuy iuy iy gy guy gu yg uyt tyudhsaduhsaguhysg yguy gdusay yguyguy tgyfuy fders srd xres esr edx reds erd t  tdr dtrd trdtrdtrdtfy ydfytfy fytfytf ytfytfyrdt fytfydtftyr dtrdedr", imageURL: "https://cdn.snapi.dev/images/v1/4/v/lucid-air-exterior-04-726948.jpg")
    }
}
