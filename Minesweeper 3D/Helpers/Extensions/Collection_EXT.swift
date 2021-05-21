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
}
