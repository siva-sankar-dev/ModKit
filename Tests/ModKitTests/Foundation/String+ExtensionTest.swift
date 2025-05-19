//
//  String+ExtensionTest.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Foundation
import ModKit
import Testing

@Suite("String Extension Tests")
struct StringExtensionTests {

    // MARK: - Boolean Properties Tests

    @Test("isNotEmpty returns correct value")
    func testIsNotEmpty() {
        #expect("Hello".isNotEmpty)
        #expect(!"".isNotEmpty)
    }

    @Test("isBlank returns correct value")
    func testIsBlank() {
        #expect("   \n ".isBlank)
        #expect(!"Hello".isBlank)
        #expect("".isBlank)
    }

    @Test("isNotBlank returns correct value")
    func testIsNotBlank() {
        #expect(!"   \n ".isNotBlank)
        #expect("Hello".isNotBlank)
        #expect(!"".isNotBlank)
    }

    // MARK: - Validation Tests

    @Test("isValidEmail validates email formats correctly")
    func testIsValidEmail() {
        let validEmails = [
            "test@example.com",
            "user.name+tag@domain.co",
            "user@sub.domain.com",
        ]

        let invalidEmails = [
            "plainstring",
            "missing@dot",
            "@missingusername.com",
            "invalid@.com",
        ]

        for email in validEmails {
            #expect(email.isValidEmail)
        }

        for email in invalidEmails {
            #expect(!email.isValidEmail)
        }
    }

    @Test("isNumeric checks correctly")
    func testIsNumeric() {
        #expect("12345".isNumeric)
        #expect(!"123.45".isNumeric)
        #expect(!"abc".isNumeric)
        #expect(!"".isNumeric)
    }

    @Test("isAlphabetic checks correctly")
    func testIsAlphabetic() {
        #expect("HelloWorld".isAlphabetic)
        #expect(!"Hello World".isAlphabetic)
        #expect(!"abc1".isAlphabetic)
        #expect(!"".isAlphabetic)
    }

    @Test("isAlphanumeric checks correctly")
    func testIsAlphanumeric() {
        #expect("AlphaNumeric123".isAlphanumeric)
        #expect(!"Alpha-Numeric".isAlphanumeric)
        #expect(!"".isAlphanumeric)
    }

    // MARK: - Conversion Tests

    @Test("url conversion works correctly")
    func testUrlConversion() {
        #expect("https://example.com".url != nil)
        #expect("not a url".url == nil)
    }

    @Test("toInt conversions work correctly")
    func testToInt() {
        #expect("123".toInt() == 123)
        #expect("abc".toInt() == nil)
        #expect("123".toInt() == 123)
        #expect("abc".toInt() == 0)
    }

    @Test("toDouble conversions work correctly")
    func testToDouble() {
        #expect("123.45".toDouble() == 123.45)
        #expect("abc".toDouble() == nil)
        #expect("123.45".toDouble() == 123.45)
        #expect("abc".toDouble() == 0.0)
    }

    @Test("toBool conversions work correctly")
    func testToBool() {
        // Optional version
        #expect("true".toBool() == true)
        #expect("FALSE".toBool() == false)
        #expect("yes".toBool() == true)
        #expect("0".toBool() == false)
        #expect("abc".toBool() == nil)

        // Non-optional version
        #expect("true".toBool())
        #expect(!"FALSE".toBool())
        #expect("yes".toBool())
        #expect(!"0".toBool())
        #expect(!"abc".toBool())
    }

    // MARK: - String Manipulation Tests

    @Test("trimmed removes whitespace correctly")
    func testTrimmed() {
        #expect("  Hello  \n".trimmed() == "Hello")
        #expect("".trimmed() == "")
    }

    @Test("capitalizingFirstLetter works correctly")
    func testCapitalizingFirstLetter() {
        #expect("hello".capitalizingFirstLetter() == "Hello")
        #expect("WORLD".capitalizingFirstLetter() == "WORLD")
        #expect("".capitalizingFirstLetter() == "")
    }

    @Test("matches regex correctly")
    func testMatches() {
        let emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
        #expect("john.doe@example.com".matches(emailRegex))
        #expect(!"notanemail".matches(emailRegex))
    }

    @Test("split works correctly")
    func testSplit() {
        #expect("a,b,c".split(by: ",") == ["a", "b", "c"])
        #expect("hello".split(by: "") == ["h", "e", "l", "l", "o"])
    }

    @Test("take and takeLast work correctly")
    func testTake() {
        #expect("Hello World".take(5) == "Hello")
        #expect("Hi".take(5) == "Hi")
        #expect("Hello World".takeLast(5) == "World")
        #expect("Hi".takeLast(5) == "Hi")
    }

    @Test("reversedString works correctly")
    func testReversedString() {
        #expect("hello".reversedString() == "olleh")
        #expect("".reversedString() == "")
    }

    // MARK: - Character and Substring Tests

    @Test("charAt returns correct character")
    func testCharAt() {
        #expect("hello".charAt(0) == "h")
        #expect("hello".charAt(4) == "o")
        #expect("hello".charAt(5) == nil)
    }

    @Test("substring returns correct substring")
    func testSubstring() {
        #expect("Hello, World!".substring(from: 0, to: 5) == "Hello")
        #expect("Hello, World!".substring(from: 7, to: 12) == "World")
        #expect("Hello, World!".substring(from: 0, to: 20) == nil)
        #expect("Hello, World!".substring(from: -1, to: 5) == nil)
    }

    @Test("removing works correctly")
    func testRemoving() {
        #expect("Hello, World! World!".removing("World") == "Hello, ! !")
        #expect("test".removing("xyz") == "test")
    }

    @Test("contains works with case sensitivity")
    func testContains() {
        #expect("Hello World".contains("world", caseSensitive: false))
        #expect(!"Hello World".contains("world", caseSensitive: true))
    }

    // MARK: - Date Formatting Tests

    @Test("toDate converts string to date correctly")
    func testToDate() {
        let dateString = "2023-05-15"
        let date = dateString.toDate(withFormat: "yyyy-MM-dd")
        #expect(date != nil)

        let components = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: date!
        )
        #expect(components.year == 2023)
        #expect(components.month == 5)
        #expect(components.day == 15)

        #expect("invalid".toDate(withFormat: "yyyy-MM-dd") == nil)
    }

    @Test("formatDate reformats date string correctly")
    func testFormatDate() {
        let result = "2023-05-15".formatDate(
            fromFormat: "yyyy-MM-dd",
            toFormat: "MM/dd/yy"
        )
        #expect(result == "05/15/23")
        #expect(
            "invalid".formatDate(fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yy")
                == nil
        )
    }

    @Test("isDateInPast checks correctly")
    func testIsDateInPast() {
        let pastDate = Calendar.current.date(
            byAdding: .day,
            value: -1,
            to: Date()
        )!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let pastDateString = formatter.string(from: pastDate)

        #expect(pastDateString.isDateInPast(withFormat: "yyyy-MM-dd"))
        #expect(!"2100-01-01".isDateInPast(withFormat: "yyyy-MM-dd"))
        #expect(!"invalid".isDateInPast(withFormat: "yyyy-MM-dd"))
    }

    @Test("isWeekend checks correctly")
    func testIsWeekend() {
        // Known weekend dates
        #expect("2023-05-14".isWeekend(withFormat: "yyyy-MM-dd"))  // Sunday
        #expect("2023-05-13".isWeekend(withFormat: "yyyy-MM-dd"))  // Saturday

        // Known weekday dates
        #expect(!"2023-05-15".isWeekend(withFormat: "yyyy-MM-dd"))  // Monday
        #expect(!"invalid".isWeekend(withFormat: "yyyy-MM-dd"))
    }

   
}
