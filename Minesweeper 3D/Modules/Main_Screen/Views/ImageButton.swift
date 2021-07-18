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
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 1)
            self.image.image
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
        .cornerRadius(12)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(
            title: "button title",
            image: .system(.play)
        )
    }
}
