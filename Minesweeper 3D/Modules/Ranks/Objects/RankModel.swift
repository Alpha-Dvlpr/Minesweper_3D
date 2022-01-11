//
//  RankModel.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import Foundation

class RankModel: Hashable, Identifiable {
    var name: String
    var ranks: [Rank]
    
    init(name: String) {
        self.name = name
        self.ranks = []
    }
    
    init(name: String, ranks: [Rank]) {
        self.name = name
        self.ranks = ranks
    }
    
    func update(ranks: [Rank]) {
        self.ranks.removeAll()
        self.ranks.append(contentsOf: ranks)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.ranks)
    }
    
    static func == (lhs: RankModel, rhs: RankModel) -> Bool {
        return lhs.name == rhs.name
            && lhs.ranks == rhs.ranks
    }
}
