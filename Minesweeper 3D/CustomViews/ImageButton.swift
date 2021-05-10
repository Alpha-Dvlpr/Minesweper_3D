//
//  ImageButton.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct ImageButton: View {

    var title: String = ""
    var image: Images
    var cornerRadius: CGFloat = 12
    var callback: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 1)
            self.image.system
                .resizable()
                .padding(1)
                .frame(width: 28, height: 28)
                .foregroundColor(.white)
            Spacer().frame(width: 4)
            Text(self.title.uppercased())
                .bold()
                .foregroundColor(.white)
                .frame(alignment: .leading)
            Spacer()
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(self.cornerRadius)
        .onTapGesture { self.callback?() }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(
            title: "button title",
            image: .play,
            cornerRadius: 25,
            callback: { }
        )
    }
}
