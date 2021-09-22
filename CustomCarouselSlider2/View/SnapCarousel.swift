//
//  SnapCarousel.swift
//  CustomCarouselSlider2
//
//  Created by Sopnil Sohan on 22/9/21.
//

import SwiftUI

struct SnapCarousel<Content: View,T: Identifiable>: View {
    
    var content: (T) -> Content
    var list: [T]
    
    //Properties...
    var spacing: CGFloat
    var trailingSpace: CGFloat
    @Binding var index: Int
    
    init(spacing: CGFloat = 15, trailingSpace: CGFloat = 100, index: Binding<Int>,items:[T], @ViewBuilder content: @escaping (T) -> Content) {
        
        self.list = items
        self.spacing = spacing
        self.trailingSpace = trailingSpace
        self._index = index
        self.content = content
        
    }
    //Offset...
    
    @GestureState var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        GeometryReader{proxy in
            
            //setting correct width for snap carsoul....
            //One side snap corusel...
            let width = proxy.size.width - (trailingSpace - spacing)
            let adjustMentWidth = (trailingSpace / 2) - spacing
            
            HStack(spacing: spacing){
                ForEach(list){item in
                    
                    content(item)
                        .frame(width: proxy.size.width - trailingSpace)
                        .offset(y: getOffset(item: item,width: width))
                }
            }
            // Spacing will be horizontal padding...
            
            .padding(.horizontal, spacing)
            
            //setting only after 0th index...
            .offset(x: (CGFloat(currentIndex) * -width) + (currentIndex != 0 ? adjustMentWidth : 0) + offset)
            .gesture(
                
                DragGesture()
                    .updating($offset, body: {value, out, _ in
                        
                        out = value.translation.width
                    })
                    .onEnded({value in
                        
                        //Updating Current Index...
                        let offset = value.translation.width
                        
                        //were going to convert thr translsation into progress (0 - 1)
                        //and round the value...
                        //based on the progress increasing or decreasing the currentindex....
                        let progress = -offset / width
                        let roundIndex = progress.rounded()
                        
                        //seting min...
                        currentIndex = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                        
                        //Updating index....
                        currentIndex = index
                    })
                    .onChanged({ value in
                        
                        let offset = value.translation.width
                        
                        //were going to convert thr translsation into progress (0 - 1)
                        //and round the value...
                        //based on the progress increasing or decreasing the currentindex....
                        let progress = -offset / width
                        let roundIndex = progress.rounded()
                        
                        //seting min...
                        index = max(min(currentIndex + Int(roundIndex), list.count - 1), 0)
                    })
            )
        }
        //Animation when offset = 0
        .animation(.easeOut, value: offset)
    }
    //Moving view based on Scroll Offset...
    func getOffset(item: T,width: CGFloat)->CGFloat {
        
        //progress....
        // Shifting Current Item to Top....
        let progress = ((offset < 0 ? offset : -offset) / width) * 60
        
        //Max 60....
        //then again minus from 60...
        let topOffset = -progress < 60 ? progress : -(progress + 120)
        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        
        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0
        
        //safty check between 0 to max list size...
        
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? (getIndex(item: item) - 1 == currentIndex ? CGFloat(previous) : next) : 0
        
        //Cheacking current...
        //if so shifting view to top...
        
        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
    }
    
    //Fetching Index...
    func getIndex(item: T)->Int {
        let index = list.firstIndex { currentItem in
            return currentItem.id == item.id
        } ?? 0
        
        return index
    }
}

struct Home_PreviewsCarsol: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
