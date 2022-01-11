//
//  Rank.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 11/01/2022.
//

import Foundation

class Rank: NSObject, NSCoding  {
    var name: String
    var date: Date
    var score: Int
    
    init(name: String, date: Date, score: Int) {
        self.name = name
        self.date = date
        self.score = score
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: CoreDataKey.ranksName.key) as? String ?? ""
        self.date = aDecoder.decodeObject(forKey: CoreDataKey.ranksDate.key) as? Date ?? Date()
        self.score = aDecoder.decodeInteger(forKey: CoreDataKey.ranksScore.key)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: CoreDataKey.ranksName.key)
        aCoder.encode(self.date, forKey: CoreDataKey.ranksDate.key)
        aCoder.encode(self.score, forKey: CoreDataKey.ranksScore.key)
    }
}
