//
//  Array+Extension.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Foundation

extension Array {

    /// Returns `true` if the array is not empty, `false` otherwise.
    /// This is an alternative to `!isEmpty`.
    public var isNotEmpty: Bool {
        !isEmpty
    }

    /// Splits the collection into chunks of a specified size.
    ///
    /// - Parameter size: The maximum size of each chunk.
    /// - Returns: An array of arrays, each containing up to `size` elements.
    public func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
    
}

extension Array where Element: Hashable {

    /// Returns a new array with duplicate elements removed, preserving the original order.
    ///
    /// This version uses a `Set` to track seen elements and is efficient (O(n) time complexity).
    ///
    /// - Returns: An array containing only the unique elements of the original array.
    public func removeDuplicates() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }

}
