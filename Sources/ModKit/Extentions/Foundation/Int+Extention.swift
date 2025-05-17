//
//  Int+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import Foundation

extension Int {

    /// Returns `true` if the integer is zero, `false` otherwise.
    ///
    /// Example:
    /// ```
    /// 0.isZero  // true
    /// 5.isZero  // false
    /// (-1).isZero // false
    /// ```
    public var isZero: Bool {
        self == 0
    }

    /// Returns `true` if the integer is an even number, `false` otherwise.
    ///
    /// Example:
    /// ```
    /// 4.isEven   // true
    /// 3.isEven   // false
    /// 0.isEven   // true
    /// (-2).isEven // true
    /// ```
    public var isEven: Bool {
        self % 2 == 0
    }

    /// Returns `true` if the integer is an odd number, `false` otherwise.
    ///
    /// Example:
    /// ```
    /// 3.isOdd    // true
    /// 4.isOdd    // false
    /// 0.isOdd    // false
    /// (-1).isOdd  // true
    /// ```
    public var isOdd: Bool {
        self % 2 != 0
    }

    /// Returns `true` if the integer is positive (greater than 0), `false` otherwise.
    ///
    /// Example:
    /// ```
    /// 10.isPositive  // true
    /// 0.isPositive   // false
    /// (-5).isPositive // false
    /// ```
    public var isPositive: Bool {
        self > 0
    }

    /// Returns `true` if the integer is negative (less than 0), `false` otherwise.
    ///
    /// Example:
    /// ```
    /// (-7).isNegative // true
    /// 0.isNegative   // false
    /// 5.isNegative   // false
    /// ```
    public var isNegative: Bool {
        self < 0
    }

    /// Returns the absolute value of the integer.
    ///
    /// Example:
    /// ```
    /// (-10).absoluteValue // 10
    /// 5.absoluteValue    // 5
    /// 0.absoluteValue    // 0
    /// ```
    public var absoluteValue: Int {
        abs(self)
    }

    /// Returns an array of the digits of the integer.
    /// For negative numbers, the sign is ignored.
    ///
    /// Example:
    /// ```
    /// 123.digits    // [1, 2, 3]
    /// 0.digits      // [0]
    /// (-456).digits // [4, 5, 6]
    /// ```
    public var digits: [Int] {
        if self == 0 { return [0] }
        return String(abs(self)).compactMap { $0.wholeNumberValue }
    }

    /// Returns the number of digits in the integer.
    /// For negative numbers, the sign is not counted.
    ///
    /// Example:
    /// ```
    /// 12345.digitCount  // 5
    /// 0.digitCount      // 1
    /// (-987).digitCount // 3
    /// ```
    public var digitCount: Int {
        if self == 0 { return 1 }
        return String(abs(self)).count
    }

    /// Executes a closure a specified number of times.
    /// The closure receives the current iteration index (0-based) as a parameter.
    /// Does nothing if the integer is zero or negative.
    ///
    /// - Parameter closure: The closure to execute.
    ///
    /// Example:
    /// ```
    /// 3.times { index in
    ///     print("Iteration \(index)")
    /// }
    /// // Output:
    /// // Iteration 0
    /// // Iteration 1
    /// // Iteration 2
    /// ```
    public func times(_ closure: (Int) -> Void) {
        guard self > 0 else { return }
        for i in 0..<self {
            closure(i)
        }
    }

    /// Executes a closure a specified number of times.
    /// Does nothing if the integer is zero or negative.
    /// This version of `times` does not pass an index to the closure.
    ///
    /// - Parameter closure: The closure to execute.
    ///
    /// Example:
    /// ```
    /// 2.times {
    ///     print("Hello")
    /// }
    /// // Output:
    /// // Hello
    /// // Hello
    /// ```
    public func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            closure()
        }
    }

    /// Checks if the integer is a prime number.
    /// A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself.
    /// Numbers less than 2 are not considered prime.
    ///
    /// Example:
    /// ```
    /// 2.isPrime  // true
    /// 3.isPrime  // true
    /// 4.isPrime  // false
    /// 17.isPrime // true
    /// 1.isPrime  // false
    /// 0.isPrime  // false
    /// (-5).isPrime // false
    /// ```
    public var isPrime: Bool {
        guard self > 1 else { return false }
        guard self > 3 else { return true }  // 2 and 3 are prime
        guard self % 2 != 0, self % 3 != 0 else { return false }  // divisible by 2 or 3

        var i = 5
        while i * i <= self {
            if self % i == 0 || self % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }

    /// Converts the integer to its string representation.
    /// This is an alternative to `String(self)`.
    ///
    /// Example:
    /// ```
    /// 100.toString // "100"
    /// (-5).toString // "-5"
    /// ```
    public var toString: String {
        String(self)
    }

    /// Converts the integer to its CGFloat representation.
    /// This is an alternative to `CGFloat(self)`.
    ///
    /// Example:
    /// ```
    /// 100.toCGFloat // 100.0
    /// (-5).toCGFloat // -5
    /// ```
    public var toCGFloat: CGFloat {
        CGFloat(self)
    }

    /// Converts the integer to its Double representation.
    /// This is an alternative to `Double(self)`.
    ///
    /// Example:
    /// ```
    /// 100.toDouble // 100.0
    /// (-5).toDouble // -5.0
    /// ```
    public var toDouble: Double {
        Double(self)
    }

    /// Formats an Int value as a price with the specified currency
    /// - Parameters:
    ///   - currency: The currency to format the price with
    ///   - displayStyle: Whether to use currency symbol or code (default is symbol)
    ///   - useGrouping: Whether to use thousands separators
    /// - Returns: A formatted price string with the appropriate currency symbol
    public func formattedAsPrice(
        in currency: Currency,
        displayStyle: Currency.DisplayStyle = .symbol,
        useGrouping: Bool = true
    ) -> String {
        return Double(self).formattedAsPrice(
            in: currency,
            displayStyle: displayStyle,
            useGrouping: useGrouping
        )
    }

}
