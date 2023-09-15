//
//  MSImageButton.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

struct MSImageButton: View {

    var title: String = ""
    var image: MSImages
    
    var body: some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 1)
            image.image
                .resizable()
                .padding(1)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
            Spacer().frame(width: 4)
            Text(title.uppercased())
                .bold()
                .foregroundColor(.white)
                .frame(alignment: .leading)
            Spacer()
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        MSImageButton(
            title: "button title",
            image: .system(.play)
        )
    }
}
