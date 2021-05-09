//
//  Image_Button.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct Image_Button: View {

    var title: String = ""
    var imageName: String
    var cornerRadius: CGFloat = 12
    var callback: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 1)
            Image(systemName: self.imageName)
                .resizable()
                .padding(1)
                .frame(width: 28, height: 28)
                .foregroundColor(Color.white)
            Spacer().frame(width: 4)
            Text(self.title.uppercased())
                .bold()
                .foregroundColor(Color.white)
                .frame(alignment: .leading)
            Spacer()
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(self.cornerRadius)
        .onTapGesture { self.callback?() }
    }
}

struct Image_Button_Previews: PreviewProvider {
    static var previews: some View {
        Image_Button(
            title: "button title",
            imageName: "plus.circle.fill",
            cornerRadius: 25,
            callback: { }
        )
    }
}
