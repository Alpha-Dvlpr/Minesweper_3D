//
//  MSLoadingView.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 29/3/24.
//

import SwiftUI

struct MSLoadingView: View {
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }
                .foregroundStyle(.blue)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
                .animation(
                    Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false),
                    value: UUID()
                )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear { isAnimating = true }
    }
    
    private func calcScale(index: Int) -> CGFloat { return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5) }
    private func calcYOffset(_ geometry: GeometryProxy) -> CGFloat { return geometry.size.width / 10 - geometry.size.height / 2 }
}
