//
//  ActionsVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 18/7/21.
//

import SwiftUI

struct ActionsVC: View {
    
    var enabled: Bool
    var callback: ((Action) -> Void)
    private var color: Color { return self.enabled ? .black : .gray }
    
    var body: some View {
        HStack(spacing: 15) {
            Spacer().frame(width: 30)
            HStack(spacing: 20) {
                self.update(image: Images.numbers(1), action: .number)
                self.update(image: Images.symbols(.flag), action: .flag)
                self.update(image: Images.symbols(.mine), action: .mine)
//                GeometryReader { shape in
//                    self.update(image: Images.symbols(.hint), action: .hint)
//                        .overlay(
//                            self.update(
//                                image: Images.numbers(Constants.numberOfHints),
//                                action: .hint
//                            )
//                            .background(Color.white)
//                            .clipShape(Circle())
//                            .frame(
//                                width: shape.size.width * 0.4,
//                                height: shape.size.height * 0.4),
//                            alignment: .topTrailing
//                        )
//                }
//                .aspectRatio(1.0, contentMode: .fit)
            }
            Spacer().frame(width: 30)
        }
    }
    
    private func update(image: Images, action: Action) -> some View {
        return image.image
            .resizable()
            .frame(width: 60, height: 60)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(self.color)
            .onTapGesture { if self.enabled { self.callback(action) } }
    }
}

struct ActionsVC_Previews: PreviewProvider {
    static var previews: some View {
        ActionsVC(enabled: true, callback: {_ in })
    }
}
