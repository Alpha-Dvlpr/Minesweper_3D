//
//  RanksVC.swift
//  Minesweeper 3D
//
//  Created by Aaron on 18/7/21.
//

import SwiftUI

struct RanksVC: View {
    
    var body: some View {
        Text("")
            .navigationBarTitle(
                Text(Texts.bestMarks.localized.uppercased()),
                displayMode: .inline
            )
    }
}

struct RanksVC_Previews: PreviewProvider {
    static var previews: some View {
        RanksVC()
    }
}
