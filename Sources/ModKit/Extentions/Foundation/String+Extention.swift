//
//  String+Extention.swift
//  ModKit
//
//  Created by Siva Sankar on 16/05/25.
//

import Foundation

extension String {

    /// Returns `true` if the string is not empty, `false` otherwise.
    /// This is an alternative to `!isEmpty`.
    public var isNotEmpty: Bool {
        !isEmpty
    }

    /// Returns `true` if the string contains only whitespace and newline characters, `false` otherwise.
    ///
    /// Example:
    /// ```
    /// "   \n ".isBlank // true
    /// "Hello".isBlank   // false
    /// "".isBlank      // true (empty string is considered blank)
    /// ```
    public var isBlank: Bool {
        self.trimmed().isEmpty
    }

    /// Returns `true` if the string contains any characters that are not whitespace or newlines.
    /// This is the inverse of `isBlank`.
    public var isNotBlank: Bool {
        !self.isBlank
    }

    /// Checks if the string is a valid email format.
    ///
    /// Uses a regular expression to verify the standard email structure.
    /// - Returns: `true` if the string matches the email pattern, otherwise `false`.
    public var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }

    /// Converts the string to a `URL` object.
    ///
    /// - Returns: A `URL` if the string is a valid URL format, otherwise `nil`.
    public var url: URL? {
        guard let url = URL(string: self), url.scheme != nil, url.host != nil
        else {
            return nil
        }
        return url
    }

    /// Attempts to convert the string to an `Int`.
    /// Returns an optional `Int`. If the conversion fails, it returns `nil`.
    ///
    /// Example:
    /// ```
    /// "123".toInt() // Optional(123)
    /// "abc".toInt() // nil
    /// ```
    public func toInt() -> Int? {
        Int(self)
    }

    /// Attempts to convert the string to a `Double`.
    /// Returns an optional `Double`. If the conversion fails, it returns `nil`.
    ///
    /// Example:
    /// ```
    /// "123.45".toDouble() // Optional(123.45)
    /// "abc".toDouble()   // nil
    /// ```
    public func toDouble() -> Double? {
        Double(self)
    }

    /// Attempts to convert the string to an `Int`.
    /// Returns an optional `Int`. If the conversion fails, it returns `nil`.
    ///
    /// Example:
    /// ```
    /// "123".toInt()
    /// "abc".toInt() // 0
    /// ```
    public func toInt() -> Int {
        Int(self) ?? 0
    }

    /// Attempts to convert the string to a `Double`.
    /// Returns an optional `Double`. If the conversion fails, it returns `nil`.
    ///
    /// Example:
    /// ```
    /// "123.45".toDouble()
    /// "abc".toDouble()   // 0.0
    /// ```
    public func toDouble() -> Double {
        Double(self) ?? 0.0
    }

    /// Attempts to convert the string to a `Bool`.
    /// Recognizes "true", "yes", "1" (case-insensitive) as true.
    /// Recognizes "false", "no", "0" (case-insensitive) as false.
    /// Returns `nil` if the string doesn't match any of these.
    ///
    /// Example:
    /// ```
    /// "true".toBool()  // Optional(true)
    /// "FALSE".toBool() // Optional(false)
    /// "yes".toBool()   // Optional(true)
    /// "0".toBool()     // Optional(false)
    /// "abc".toBool()   // nil
    /// ```
    public func toBool() -> Bool? {
        let lowercased = self.lowercased()
        switch lowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    /// Returns the string trimmed of leading and trailing whitespace and newline characters.
    ///
    /// Example:
    /// ```
    /// "  Hello, World!  \n".trimmed() // "Hello, World!"
    /// ```
    public func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Attempts to convert the string to a `Bool`.
    /// Recognizes "true", "yes", "1" (case-insensitive) as true.
    /// Recognizes "false", "no", "0" (case-insensitive) as false.
    /// Returns `nil` if the string doesn't match any of these.
    ///
    /// Example:
    /// ```
    /// "true".toBool()  // true
    /// "FALSE".toBool() // false
    /// "yes".toBool()   // true
    /// "0".toBool()     // false
    /// "abc".toBool()   // false
    /// ```
    public func toBool() -> Bool {
        let lowercased = self.lowercased()
        switch lowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return false
        }
    }

    /// Returns a new string with the first letter capitalized and the rest of the string unchanged.
    /// If the string is empty, it returns an empty string.
    ///
    /// Example:
    /// ```
    /// "hello".capitalizedFirst() // "Hello"
    /// "WORLD".capitalizedFirst() // "WORLD" (Only the first character is considered)
    /// "".capitalizedFirst()     // ""
    /// ```
    public func capitalizingFirstLetter() -> String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }

    /// Checks if the string matches a given regular expression pattern.
    ///
    /// - Parameter regex: The regular expression pattern to match against.
    /// - Returns: `true` if the string matches the pattern, `false` otherwise.
    ///
    /// Example:
    /// ```
    /// "john.doe@example.com".matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$") // true
    /// "notanemail".matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")         // false
    /// ```
    public func matches(_ regex: String) -> Bool {
        self.range(
            of: regex,
            options: .regularExpression,
            range: nil,
            locale: nil
        ) != nil
    }

    /// Returns an array of strings, splitting the string by a given separator.
    /// If the separator is an empty string, it splits the string into an array of individual characters.
    ///
    /// - Parameter separator: The string to use as a separator.
    /// - Returns: An array of substrings.
    ///
    /// Example:
    /// ```
    /// "apple,banana,orange".split(by: ",") // ["apple", "banana", "orange"]
    /// "hello".split(by: "")                // ["h", "e", "l", "l", "o"]
    /// ```
    public func split(by separator: String) -> [String] {
        if separator.isEmpty {
            return self.map { String($0) }
        }
        return self.components(separatedBy: separator)
    }

    /// Returns a new string containing the characters of the String from the beginning up to, but not including, the specified number of characters.
    /// If the count exceeds the string's length, the entire string is returned.
    ///
    /// - Parameter count: The number of characters to take from the beginning.
    /// - Returns: A new string.
    ///
    /// Example:
    /// ```
    /// "Hello World".prefix(5) // "Hello"
    /// "Hi".prefix(5)          // "Hi"
    /// ```
    public func take(_ count: Int) -> String {
        String(self.prefix(count))
    }

    /// Returns a new string containing the characters of the String from the end up to, but not including, the specified number of characters.
    /// If the count exceeds the string's length, the entire string is returned.
    ///
    /// - Parameter count: The number of characters to take from the end.
    /// - Returns: A new string.
    ///
    /// Example:
    /// ```
    /// "Hello World".suffix(5) // "World"
    /// "Hi".suffix(5)          // "Hi"
    /// ```
    public func takeLast(_ count: Int) -> String {
        String(self.suffix(count))
    }

    /// Reverses the string.
    ///
    /// Example:
    /// ```
    /// "hello".reversedString() // "olleh"
    /// ```
    public func reversedString() -> String {
        String(self.reversed())
    }

    /// Checks if the string contains only numeric characters.
    ///
    /// Example:
    /// ```
    /// "12345".isNumeric // true
    /// "123.45".isNumeric // false (due to the decimal point)
    /// "abc".isNumeric   // false
    /// "".isNumeric      // false (or true depending on desired behavior for empty string, here false)
    /// ```
    public var isNumeric: Bool {
        guard !self.isEmpty else { return false }
        return self.allSatisfy { $0.isNumber }
    }

    /// Checks if the string contains only alphabetic characters.
    ///
    /// Example:
    /// ```
    /// "HelloWorld".isAlphabetic // true
    /// "Hello World".isAlphabetic // false (due to space)
    /// "abc1".isAlphabetic     // false
    /// "".isAlphabetic        // false
    /// ```
    public var isAlphabetic: Bool {
        guard !self.isEmpty else { return false }
        return self.allSatisfy { $0.isLetter }
    }

    /// Checks if the string contains only alphanumeric characters (letters and numbers).
    ///
    /// Example:
    /// ```
    /// "AlphaNumeric123".isAlphaNumeric // true
    /// "Alpha-Numeric".isAlphaNumeric  // false (due to hyphen)
    /// "".isAlphaNumeric             // false
    /// ```
    public var isAlphanumeric: Bool {
        guard !self.isEmpty else { return false }
        return self.allSatisfy { $0.isLetter || $0.isNumber }
    }

    /// Returns the character at a specific index.
    /// Returns `nil` if the index is out of bounds.
    ///
    /// - Parameter index: The integer index of the character.
    /// - Returns: An optional `Character`.
    ///
    /// Example:
    /// ```
    /// "hello".charAt(0) // Optional("h")
    /// "hello".charAt(4) // Optional("o")
    /// "hello".charAt(5) // nil
    /// ```
    public func charAt(_ index: Int) -> Character? {
        guard index >= 0 && index < self.count else {
            return nil
        }
        return self[self.index(self.startIndex, offsetBy: index)]
    }

    /// Returns a substring from the specified start index up to the specified end index (exclusive).
    /// Returns `nil` if indices are invalid or out of bounds.
    ///
    /// - Parameters:
    ///   - start: The starting index of the substring.
    ///   - end: The ending index (exclusive) of the substring.
    /// - Returns: An optional `String` representing the substring.
    ///
    /// Example:
    /// ```
    /// "Hello, World!".substring(from: 0, to: 5)  // Optional("Hello")
    /// "Hello, World!".substring(from: 7, to: 12) // Optional("World")
    /// "Hello, World!".substring(from: 0, to: 20) // nil (end out of bounds)
    /// "Hello, World!".substring(from: -1, to: 5) // nil (start out of bounds)
    /// "Hello, World!".substring(from: 5, to: 0)  // nil (start > end)
    /// ```
    public func substring(from start: Int, to end: Int) -> String? {
        guard start >= 0, end >= 0, end <= self.count, start < end else {
            return nil
        }
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }

    /// Returns a new string by removing all occurrences of a given substring.
    ///
    /// - Parameter substring: The substring to remove.
    /// - Returns: A new string with the substring removed.
    ///
    /// Example:
    /// ```
    /// "Hello, World! World!".removing("World") // "Hello, ! !"
    /// "test".removing("xyz")                  // "test"
    /// ```
    public func removing(_ substring: String) -> String {
        self.replacingOccurrences(of: substring, with: "")
    }

    /// Returns `true` if the string contains the specified substring, considering case sensitivity.
    ///
    /// - Parameter substring: The substring to search for.
    /// - Returns: `true` if the substring is found, `false` otherwise.
    public func contains(_ substring: String, caseSensitive: Bool = true)
        -> Bool
    {
        if caseSensitive {
            return self.range(of: substring) != nil
        } else {
            return self.lowercased().range(of: substring.lowercased()) != nil
        }
    }

    //MARK: - Date Formmating

    /// Convert string to Date using specified format
    /// - Parameter format: Date format (e.g., "yyyy-MM-dd")
    /// - Returns: Date object if conversion successful, nil otherwise
    public func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }

    /// Format a date string from one format to another
    /// - Parameters:
    ///   - fromFormat: Source date format
    ///   - toFormat: Target date format
    /// - Returns: Formatted date string or nil if conversion fails
    public func formatDate(fromFormat: String, toFormat: String) -> String? {
        guard let date = self.toDate(withFormat: fromFormat) else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: date)
    }

    /// Check if string represents a date in the past
    /// - Parameter format: Date format to interpret the string
    /// - Returns: Bool indicating if date is in the past
    public func isDateInPast(withFormat format: String) -> Bool {
        guard let date = self.toDate(withFormat: format) else {
            return false
        }
        return date < Date()
    }

    /// Check if date string represents a weekend
    /// - Parameter format: Date format
    /// - Returns: Bool indicating whether date falls on a weekend
    public func isWeekend(withFormat format: String) -> Bool {
        guard let date = self.toDate(withFormat: format) else {
            return false
        }

        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7  // Sunday or Saturday
    }

    // MARK: - Price Formatting

    /// Formats a string that contains a numeric value as a price with the specified currency
    /// - Parameters:
    ///   - currency: The currency to format the price with
    ///   - displayStyle: Whether to use currency symbol or code (default is symbol)
    ///   - useGrouping: Whether to use thousands separators
    /// - Returns: A formatted price string with the appropriate currency symbol, or nil if the string cannot be converted to a number
    public func formattedAsPrice(
        in currency: Currency,
        displayStyle: Currency.DisplayStyle = .symbol,
        useGrouping: Bool = true
    ) -> String? {
        guard let value = Double(self) else {
            return nil
        }

        return value.formattedAsPrice(
            in: currency,
            displayStyle: displayStyle,
            useGrouping: useGrouping
        )
    }

    /// Attempts to format a string as a price with a currency symbol added
    /// This is a convenience method that doesn't require creating a Currency enum
    /// - Parameters:
    ///   - currencySymbol: The currency symbol to add (e.g., "$", "₹", "€")
    ///   - isPrefix: Whether the symbol should appear before the amount (true) or after (false)
    ///   - decimalPlaces: Number of decimal places to show (default is 2)
    /// - Returns: A formatted price string, or nil if the string isn't a valid number
    public func formattedAsPrice(
        withSymbol currencySymbol: String,
        isPrefix: Bool = true,
        decimalPlaces: Int = 2,
        useGrouping: Bool = true
    ) -> String? {
        guard let value = Double(self) else {
            return nil
        }

        _ = Currency.custom(
            code: "XXX",
            symbol: currencySymbol,
            position: isPrefix ? .prefix : .suffix
        )

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = decimalPlaces
        formatter.maximumFractionDigits = decimalPlaces
        formatter.usesGroupingSeparator = useGrouping

        guard
            let formattedNumber = formatter.string(from: NSNumber(value: value))
        else {
            return nil
        }

        return isPrefix
            ? "\(currencySymbol)\(formattedNumber)"
            : "\(formattedNumber)\(currencySymbol)"
    }
}
