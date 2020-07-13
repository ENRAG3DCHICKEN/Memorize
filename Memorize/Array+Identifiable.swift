//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by user177069 on 7/9/20.
//  Copyright © 2020 CS193p. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
