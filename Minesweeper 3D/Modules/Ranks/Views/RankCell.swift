//
//  RankCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import SwiftUI

struct RankCell: View {
    
    var rank: Rank
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(self.rank.score)")
                .font(.title2)
            Text(Utils.getFormattedDate(from: self.rank.date))
                .font(.caption)
        }
    }
}

struct RankCell_Previews: PreviewProvider {
    static var previews: some View {
        RankCell(rank: Rank(name: "Aarón", date: Date(), score: 475))
    }
}
