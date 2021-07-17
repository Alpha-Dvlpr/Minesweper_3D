//
//  Collection_EXT.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import Foundation

extension Collection where Self.Iterator.Element: Collection {
    
    var transposed: [[Self.Iterator.Element.Iterator.Element]] {
        var result = [[Self.Iterator.Element.Iterator.Element]]()
        
        if self.isEmpty { return result }
        
        var index = self.first!.startIndex
        
        while index != self.first!.endIndex {
            var subResult = [Self.Iterator.Element.Iterator.Element]()
            
            for subArray in self { subResult.append(subArray[index]) }
            
            result.append(subResult)
            
            index = self.first!.index(after: index)
        }
        
        return result
    }
    
    var reversedRows: [[Self.Iterator.Element.Iterator.Element]] {
        var result = [[Self.Iterator.Element.Iterator.Element]]()
        
        if self.isEmpty { return result }
        
        for subArray in self { result.append(subArray.reversed()) }
        
        return result
    }
    
    var reversedColumns: [[Self.Iterator.Element.Iterator.Element]] {
        var result = [[Self.Iterator.Element.Iterator.Element]]()
        
        if self.isEmpty { return result }
        
        for subArray in self { result.append(subArray.map { return $0 }) }
        
        return result.reversed()
    }
    
    func vertical(at index: Int, reversed: Bool = false) -> [Self.Iterator.Element.Iterator.Element]? {
        guard index < self.count else { return nil }
        
        var result = [Self.Iterator.Element.Iterator.Element]()
        
        for subArray in self { result.append(subArray.map { return $0 }[index]) }
        
        guard result.count == Constants.numberOfItems else { return nil }
        
        return reversed ? result.reversed() : result
    }
    
    func horizontal(at index: Int, reversed: Bool = false) -> [Self.Iterator.Element.Iterator.Element]? {
        guard index < self.count else { return nil }
        
        let result: [Self.Iterator.Element.Iterator.Element] = self.map { return $0.map { return $0 } }[index]
        
        guard result.count == Constants.numberOfItems else { return nil }
        
        return reversed ? result.reversed() : result
    }
}

extension Collection where Self == [Face] {
    
    static func << (number: Int, array: Self) -> Face? {
        return array.first(where: { $0.number == number })
    }
    
    static func >> (array: Self, number: Int) -> Int? {
        return array.firstIndex(where: { $0.number == number })
    }
    
    static func >> (array: Self, references: References) -> BoardT_4? {
        guard let _self = references._self << array,
              let top =  references.top << array,
              let bottom =  references.bottom << array,
              let left =  references.left << array,
              let right =  references.right << array
        else { return nil }
    
        let firstIndex = 1
        let lastIndex = Constants.numberOfItems - 2
        
        top.updateNewReferences(from: _self, to: .up)
        bottom.updateNewReferences(from: _self, to: .down)
        left.updateNewReferences(from: _self, to: .left)
        right.updateNewReferences(from: _self, to: .right)
        
        let topCells = top.rotated.cells.b.horizontal(at: lastIndex) ?? []
        let bottomCells = bottom.rotated.cells.b.horizontal(at: firstIndex) ?? []
        let leftCells = left.rotated.cells.b.vertical(at: lastIndex) ?? []
        let rightCells = right.rotated.cells.b.vertical(at: firstIndex) ?? []
        
        return BoardT_4(topCells, bottomCells, leftCells, rightCells).ok
    }
}
