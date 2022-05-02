//
//  RatingView.swift
//  RatingAnimation
//
//  Created by Ali Mert Özhayta on 2.05.2022.
//

import SwiftUI

struct RatingView: View {

    private let startCount: Int
    @State private var rating: Int = 0
    
    init(starCount: Int = 5) {
        self.startCount = starCount
    }
    
    var body: some View {
        starsView
            .overlay {
                overlayView
                    .mask(starsView)
            }
    }
    
    private var starsView: some View {
        ZStack {
            HStack {
                ForEach(0..<5) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .shadow(color: Color(UIColor.label), radius: 1, x: 1, y: 1)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                rating = index + 1
                            }
                        }
                }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(colors: [.orange, .yellow], startPoint: .bottomLeading, endPoint: .topTrailing))
                    .frame(width: (CGFloat(rating) / CGFloat(startCount)) * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingView()
                .preferredColorScheme(.dark)
            RatingView()
                .preferredColorScheme(.light)
        }
    }
}
