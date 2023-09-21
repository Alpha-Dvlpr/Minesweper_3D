//
//  SwipeActionView.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//  credit: https://swiftuirecipes.com/blog/swiftui-list-custom-row-swipe-actions-all-versions
//

import SwiftUI

//struct SwipeActionView: ViewModifier {
//
//    private static let minSwipeableWidth = SwipeButton.width * 0.8
//    
//    let leading: [SwipeButton]
//    let trailing: [SwipeButton]
//    let canFullSwipeL: Bool
//    let canFullSwipeT: Bool
//    private let totalLWidth: CGFloat!
//    private let totalTWidth: CGFloat!
//    
//    @State private var offset: CGFloat = 0
//    @State private var prevOffset: CGFloat = 0
//    
//    init(
//        leading: [SwipeButton] = [],
//        trailing: [SwipeButton] = [],
//        canFullSwipeL: Bool = false,
//        canFullSwipeT: Bool = false
//    ) {
//        self.leading = leading
//        self.trailing = trailing
//        self.canFullSwipeL = canFullSwipeL && !leading.isEmpty
//        self.canFullSwipeT = canFullSwipeT && !trailing.isEmpty
//        self.totalLWidth = SwipeButton.width * CGFloat(leading.count)
//        self.totalTWidth = SwipeButton.width * CGFloat(trailing.count)
//    }
//    
//    func body(content: Content) -> some View {
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                if self.offset > 0 {
//                    if self.fullSwipe(.leading, width: geometry.size.width) {
//                        self.button(for: leading.first)
//                            .frame(width: self.offset, height: geometry.size.height)
//                    } else {
//                        ForEach(self.leading) { actionView in
//                            self.button(for: actionView)
//                                .frame(width: self.buttonWidth(.leading), height: geometry.size.height)
//                        }
//                    }
//                }
//                content
//                    .padding(.horizontal, 16)
//                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
//                    .offset(x: self.offset > 0 ? 0 : self.offset)
//                if self.offset < 0 {
//                    Group {
//                        if self.fullSwipe(.trailing, width: geometry.size.width) {
//                            self.button(for: self.trailing.last)
//                                .frame(width: -self.offset, height: geometry.size.height)
//                        } else {
//                            ForEach(self.trailing) { actionView in
//                                self.button(for: actionView)
//                                    .frame(width: self.buttonWidth(.trailing), height: geometry.size.height)
//                            }
//                        }
//                    }
//                    .offset(x: self.offset)
//                }
//            }
//            .animation(.spring(), value: self.offset)
//            .contentShape(Rectangle())
//            .gesture(
//                DragGesture(minimumDistance: 10, coordinateSpace: .local)
//                    .onChanged { self.handleGestureChange(for: $0) }
//                    .onEnded { _ in self.handleGestureEnd(with: geometry) }
//            )
//        }
//        .listRowInsets(EdgeInsets())
//    }
//    
//    private func fullSwipe(_ edge: Edge, width: CGFloat) -> Bool {
//        let threshold = abs(width) / 2
//        switch edge {
//        case .leading: return self.canFullSwipeL && self.offset > threshold
//        case .trailing: return self.canFullSwipeT && -self.offset > threshold
//        }
//    }
//    
//    private func button(for button: SwipeButton?) -> some View {
//        button?
//            .onTapGesture {
//                button?.action()
//                self.offset = 0
//                self.prevOffset = 0
//            }
//    }
//    
//    private func buttonWidth(_ edge: Edge) -> CGFloat {
//        switch edge {
//        case .leading: return self.offset > 0 ? (self.offset / CGFloat(self.leading.count)) : 0
//        case .trailing: return self.offset < 0 ? (abs(self.offset) / CGFloat(self.trailing.count)) : 0
//        }
//    }
//    
//    private func handleSwipe(for buttons: [SwipeButton], _ edge: Edge, width: CGFloat) -> Bool {
//        if self.fullSwipe(edge, width: width) {
//            self.offset = width * CGFloat(buttons.count) * 1.2
//            (edge == .leading ? buttons.first : buttons.last)?.action()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self.offset = 0
//                self.prevOffset = 0
//            }
//            return true
//        } else {
//            return false
//        }
//    }
//    
//    private func handleGestureChange(for gesture: DragGesture.Value) {
//        var total = gesture.translation.width + self.prevOffset
//        if !self.canFullSwipeL { total = min(total, self.totalLWidth) }
//        if !self.canFullSwipeT { total = max(total, -self.totalTWidth) }
//        self.offset = total
//    }
//    
//    private func handleGestureEnd(with geometry: GeometryProxy) {
//        if self.offset > SwipeActionView.minSwipeableWidth && !self.leading.isEmpty {
//            if !self.handleSwipe(for: self.leading, .leading, width: geometry.size.width) {
//                self.offset = self.totalLWidth
//            }
//        } else if self.offset < -SwipeActionView.minSwipeableWidth && !self.trailing.isEmpty {
//            if !self.handleSwipe(for: self.trailing, .trailing, width: -geometry.size.width) {
//                self.offset = -self.totalTWidth
//            }
//        } else {
//            self.offset = 0
//        }
//        self.prevOffset = self.offset
//    }
//    
//    private enum Edge {
//        case leading, trailing
//    }
//}

//extension View {
//    func swipeActions(
//        leading: [SwipeButton] = [], trailing: [SwipeButton] = [],
//        canFullSwipeL: Bool = false, canFullSwipeT: Bool = false
//    ) -> some View {
//        modifier(
//            SwipeActionView(
//                leading: leading, trailing: trailing,
//                canFullSwipeL: canFullSwipeL, canFullSwipeT: canFullSwipeT
//            )
//        )
//    }
//}
