//
//  ShopVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 18/7/21.
//

import SwiftUI

struct ShopVC: View {
    
    var body: some View {
        Text("")
            .navigationBarTitle(
                Text(Texts.shop.localized.uppercased()),
                displayMode: .inline
            )
    }
}

struct ShopVC_Previews: PreviewProvider {
    static var previews: some View {
        ShopVC()
    }
}
