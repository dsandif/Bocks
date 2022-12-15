
import Foundation
import SwiftUI
import ACarousel

struct Carousel: View {
    let items: [CarouselItem]
    
    var body: some View {
        ACarousel(items) { item in
            item.content
                .padding([.vertical], 25)
//                .border(Color.white, width: 1)
        }
        .frame(height: 500)
    }
}

struct CarouselItem : Identifiable {
    var id = UUID()
    var content : AnyView
}


