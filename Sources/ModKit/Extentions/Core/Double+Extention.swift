//
//  Double+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import Foundation

public extension Double {

    /// Returns `true` if the double is effectively zero, considering a small tolerance for floating-point comparisons.
    ///
    /// Example:
    /// ```
    /// 0.0.isZero      // true
    /// 0.0000000001.isZero // true (depending on tolerance)
    /// 5.5.isZero      // false
    /// (-0.00000000009).isZero // true (depending on tolerance)
    /// ```
    var isZero: Bool {
        // It's generally better to compare floating-point numbers against a small epsilon (tolerance)
        // rather than direct equality with zero, due to potential precision issues.
        abs(self) < Double.ulpOfOne.squareRoot() // A common tolerance
    }

    /// Returns `true` if the double is positive (greater than 0).
    ///
    /// Example:
    /// ```
    /// 10.5.isPositive  // true
    /// 0.0.isPositive   // false
    /// (-5.2).isPositive // false
    /// ```
    var isPositive: Bool {
        self > 0.0
    }

    /// Returns `true` if the double is negative (less than 0).
    ///
    /// Example:
    /// ```
    /// (-7.1).isNegative // true
    /// 0.0.isNegative   // false
    /// 5.8.isNegative   // false
    /// ```
    var isNegative: Bool {
        self < 0.0
    }

    /// Returns the absolute value of the double.
    ///
    /// Example:
    /// ```
    /// (-10.75).absoluteValue // 10.75
    /// 5.33.absoluteValue    // 5.33
    /// 0.0.absoluteValue     // 0.0
    /// ```
    var absoluteValue: Double {
        abs(self)
    }
    
    /// Rounds the double to a specified number of decimal places.
    ///
    /// - Parameter places: The number of decimal places to round to. Must be non-negative.
    /// - Returns: The rounded double.
    ///
    /// Example:
    /// ```
    /// 3.14159.rounded(toPlaces: 2) // 3.14
    /// 1.23456.rounded(toPlaces: 0) // 1.0
    /// 10.0.rounded(toPlaces: 3)    // 10.0
    /// 0.129.rounded(toPlaces: 2)   // 0.13
    /// ```
    func rounded(toPlaces places: Int) -> Double {
        guard places >= 0 else { return self } // Or handle error
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /// Returns the largest integer less than or equal to the double.
    ///
    /// Example:
    /// ```
    /// 5.8.floored()  // 5.0
    /// (-3.2).floored() // -4.0
    /// 7.0.floored()  // 7.0
    /// ```
    func floored() -> Double {
        floor(self)
    }

    /// Returns the smallest integer greater than or equal to the double.
    ///
    /// Example:
    /// ```
    /// 5.2.ceiled()  // 6.0
    /// (-3.8).ceiled() // -3.0
    /// 7.0.ceiled()  // 7.0
    /// ```
    func ceiled() -> Double {
        ceil(self)
    }

    /// Checks if the double represents an integer value (i.e., has no fractional part or the fractional part is effectively zero).
    ///
    /// Example:
    /// ```
    /// 5.0.isInteger      // true
    /// 5.1.isInteger      // false
    /// (-3.0).isInteger   // true
    /// 0.0000000000001.isInteger // false (unless it's within tolerance of an integer)
    /// ```
    var isInteger: Bool {
        // Compares the double with its floored value, considering a small tolerance
        abs(self - self.floored()) < Double.ulpOfOne.squareRoot()
    }


    /// Clamps the double to a given range.
    /// If the double is less than `min`, `min` is returned.
    /// If the double is greater than `max`, `max` is returned.
    /// Otherwise, the double itself is returned.
    ///
    /// - Parameters:
    ///   - range: The closed range to clamp to.
    /// - Returns: The clamped double.
    ///
    /// Example:
    /// ```
    /// 5.5.clamped(to: 0.0...10.0)  // 5.5
    /// 15.2.clamped(to: 0.0...10.0) // 10.0
    /// (-5.0).clamped(to: 0.0...10.0) // 0.0
    /// ```
    func clamped(to range: ClosedRange<Double>) -> Double {
        min(max(self, range.lowerBound), range.upperBound)
    }

    /// Returns the fractional part of the double.
    ///
    /// Example:
    /// ```
    /// 3.14159.fractionalPart  // 0.14159 (approximately)
    /// (-2.75).fractionalPart // -0.75 (or 0.25 depending on definition, here it keeps the sign)
    /// 10.0.fractionalPart   // 0.0
    /// ```
    var fractionalPart: Double {
        self - trunc(self) // trunc removes the fractional part towards zero
    }

    /// Checks if the double is a "Not a Number" (NaN) value.
    ///
    /// Example:
    /// ```
    /// Double.nan.isNotANumber // true
    /// (0.0/0.0).isNotANumber  // true
    /// 5.0.isNotANumber      // false
    /// ```
    var isNotANumber: Bool {
        self.isNaN
    }

    /// Checks if the double is an infinite value (positive or negative infinity).
    ///
    /// Example:
    /// ```
    /// Double.infinity.isInfiniteValue // true
    /// (-Double.infinity).isInfiniteValue // true
    /// 5.0.isInfiniteValue             // false
    /// ```
    var isInfiniteValue: Bool {
        self.isInfinite
    }
    
    /// Converts the double to its string representation.
    ///
    /// Example:
    /// ```
    /// 100.23.toString // "100.23"
    /// (-5.0).toString  // "-5.0"
    /// ```
    var toString: String {
        String(self)
    }

    /// Converts the double to an `Int`, truncating any fractional part.
    ///
    /// Example:
    /// ```
    /// 5.8.toInt  // 5
    /// (-3.9).toInt // -3
    /// 0.1.toInt  // 0
    /// ```
    var toInt: Int {
        Int(self)
    }

    /// Rounds the double to the nearest integer.
    /// Uses the "round half to even" rounding rule by default.
    ///
    /// Example:
    /// ```
    /// 5.8.roundedToInt() // 6
    /// 5.2.roundedToInt() // 5
    /// 5.5.roundedToInt() // 6 (round half to even)
    /// (-3.7).roundedToInt() // -4
    /// ```
    func roundedToInt() -> Int {
        Int(self.rounded())
    }
    
    /// Converts the double to an `CGFloat`, truncating any fractional part.
    ///
    /// Example:
    /// ```
    /// 5.8.toCGFloat  // 5.0
    /// (-3.9).toCGFloat // -3.0
    /// 0.1.toCGFloat  // 0.0
    /// ```
    var toCGFloat: CGFloat {
        CGFloat(self)
    }
}

