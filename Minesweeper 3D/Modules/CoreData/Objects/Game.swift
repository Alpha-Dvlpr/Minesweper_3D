//
//  Game.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import Foundation

//class Game: NSObject, NSCoding {
//    
//    var faces: [FaceCD]
//    var visibleFace: FaceCD
//    var time: Int
//    var status: GameStatus
//    
//    init(faces: [Face], visibleFace: Face, time: Int, status: GameStatus) {
//        self.faces = faces.map { return $0.getDaceCD() }
//        self.visibleFace = visibleFace.getDaceCD()
//        self.time = time
//        self.status = status
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        let decodedStatus = aDecoder.decodeObject(forKey: CoreDataKey.status.key) as? String ?? ""
//        
//        self.faces = (aDecoder.decodeObject(forKey: CoreDataKey.faces.key) as? [FaceCD])!
//        self.visibleFace = (aDecoder.decodeObject(forKey: CoreDataKey.visibleFace.key) as? FaceCD)!
//        self.time = aDecoder.decodeInteger(forKey: CoreDataKey.time.key)
//        self.status = GameStatus(rawValue: decodedStatus) ?? .paused
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.faces, forKey: CoreDataKey.faces.key)
//        aCoder.encode(self.visibleFace, forKey: CoreDataKey.visibleFace.key)
//        aCoder.encode(self.time, forKey: CoreDataKey.time.key)
//        aCoder.encode(self.status.rawValue, forKey: CoreDataKey.status.key)
//    }
//}
