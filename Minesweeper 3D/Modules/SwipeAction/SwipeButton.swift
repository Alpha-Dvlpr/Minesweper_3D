//
//  SwipeButton.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import SwiftUI

struct SwipeButton: View, Identifiable {
    
    static let width: CGFloat = 70
    
    let id = UUID()
    let icon: Image?
    let action: (() -> Void)
    let tint: Color?
    
    init(
        icon: Image? = nil,
        action: @escaping () -> Void,
        tint: Color? = nil
    ) {
        self.icon = icon
        self.action = action
        self.tint = tint ?? .gray
    }
    
    var body: some View {
        ZStack {
            self.tint
            VStack {
                if let icon = self.icon { icon }
            }
            .foregroundColor(.white)
            .frame(width: SwipeButton.width)
        }
    }
}

struct SwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(icon: Images.system(.share).image, action: { })
    }
}
