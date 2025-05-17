//
//  Double+ExtentionTests.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Testing
import ModKit
import CoreGraphics

@Suite("Double Extention Tests")
struct DoubleExtentionTests {
    
       // MARK: - isZero Tests
       
       @Test("isZero correctly identifies zero values")
       func testIsZeroWithZeroValue() throws {
           let zero = 0.0
           #expect(zero.isZero)
       }
       
       @Test("isZero correctly identifies very small values as zero")
       func testIsZeroWithVerySmallValue() throws {
           let verySmallValue = 0.0000000001
           // This test may fail if the tolerance is stricter than this value
           #expect(verySmallValue.isZero)
       }
       
       @Test("isZero correctly identifies non-zero values")
       func testIsZeroWithNonZeroValue() throws {
           let nonZero = 5.5
           #expect(!nonZero.isZero)
       }
       
       @Test("isZero handles negative values close to zero")
       func testIsZeroWithNegativeValueCloseToZero() throws {
           let negativeSmall = -0.00000000009
           #expect(negativeSmall.isZero)
       }
       
       // MARK: - isPositive Tests
       
       @Test("isPositive correctly identifies positive values")
       func testIsPositiveWithPositiveValue() throws {
           let positive = 10.5
           #expect(positive.isPositive)
       }
       
       @Test("isPositive correctly identifies zero as not positive")
       func testIsPositiveWithZero() throws {
           let zero = 0.0
           #expect(!zero.isPositive)
       }
       
       @Test("isPositive correctly identifies negative values as not positive")
       func testIsPositiveWithNegativeValue() throws {
           let negative = -5.2
           #expect(!negative.isPositive)
       }
       
       // MARK: - isNegative Tests
       
       @Test("isNegative correctly identifies negative values")
       func testIsNegativeWithNegativeValue() throws {
           let negative = -7.1
           #expect(negative.isNegative)
       }
       
       @Test("isNegative correctly identifies zero as not negative")
       func testIsNegativeWithZero() throws {
           let zero = 0.0
           #expect(!zero.isNegative)
       }
       
       @Test("isNegative correctly identifies positive values as not negative")
       func testIsNegativeWithPositiveValue() throws {
           let positive = 5.8
           #expect(!positive.isNegative)
       }
       
       // MARK: - absoluteValue Tests
       
       @Test("absoluteValue correctly returns absolute value of negative number")
       func testAbsoluteValueWithNegativeNumber() throws {
           let negative = -10.75
           #expect(negative.absoluteValue == 10.75)
       }
       
       @Test("absoluteValue correctly returns absolute value of positive number")
       func testAbsoluteValueWithPositiveNumber() throws {
           let positive = 5.33
           #expect(positive.absoluteValue == 5.33)
       }
       
       @Test("absoluteValue correctly returns absolute value of zero")
       func testAbsoluteValueWithZero() throws {
           let zero = 0.0
           #expect(zero.absoluteValue == 0.0)
       }
       
       // MARK: - rounded(toPlaces:) Tests
       
       @Test("rounded(toPlaces:) correctly rounds to specified decimal places")
       func testRoundedToPlaces() throws {
           let value = 3.14159
           #expect(value.rounded(toPlaces: 2) == 3.14)
       }
       
       @Test("rounded(toPlaces:) correctly rounds to zero decimal places")
       func testRoundedToZeroPlaces() throws {
           let value = 1.23456
           #expect(value.rounded(toPlaces: 0) == 1.0)
       }
       
       @Test("rounded(toPlaces:) correctly handles number without decimal part")
       func testRoundedToPlacesWithIntegerValue() throws {
           let value = 10.0
           #expect(value.rounded(toPlaces: 3) == 10.0)
       }
       
       @Test("rounded(toPlaces:) correctly rounds up")
       func testRoundedToPlacesRoundingUp() throws {
           let value = 0.129
           #expect(value.rounded(toPlaces: 2) == 0.13)
       }
       
       @Test("rounded(toPlaces:) handles negative places by returning self")
       func testRoundedToNegativePlaces() throws {
           let value = 3.14159
           #expect(value.rounded(toPlaces: -2) == value)
       }
       
       // MARK: - floored Tests
       
       @Test("floored correctly returns largest integer less than or equal to value")
       func testFlooredWithFractionalPart() throws {
           let value = 5.8
           #expect(value.floored() == 5.0)
       }
       
       @Test("floored correctly handles negative values")
       func testFlooredWithNegativeValue() throws {
           let value = -3.2
           #expect(value.floored() == -4.0)
       }
       
       @Test("floored correctly handles integer values")
       func testFlooredWithIntegerValue() throws {
           let value = 7.0
           #expect(value.floored() == 7.0)
       }
       
       // MARK: - ceiled Tests
       
       @Test("ceiled correctly returns smallest integer greater than or equal to value")
       func testCeiledWithFractionalPart() throws {
           let value = 5.2
           #expect(value.ceiled() == 6.0)
       }
       
       @Test("ceiled correctly handles negative values")
       func testCeiledWithNegativeValue() throws {
           let value = -3.8
           #expect(value.ceiled() == -3.0)
       }
       
       @Test("ceiled correctly handles integer values")
       func testCeiledWithIntegerValue() throws {
           let value = 7.0
           #expect(value.ceiled() == 7.0)
       }
       
       // MARK: - isInteger Tests
       
       @Test("isInteger correctly identifies integer values")
       func testIsIntegerWithIntegerValue() throws {
           let value = 5.0
           #expect(value.isInteger)
       }
       
       @Test("isInteger correctly identifies non-integer values")
       func testIsIntegerWithNonIntegerValue() throws {
           let value = 5.1
           #expect(!value.isInteger)
       }
       
       @Test("isInteger correctly handles negative integers")
       func testIsIntegerWithNegativeIntegerValue() throws {
           let value = -3.0
           #expect(value.isInteger)
       }
       
       @Test("isInteger correctly handles values very close to integers")
       func testIsIntegerWithValueVeryCloseToInteger() throws {
           let value = 5.0 + Double.ulpOfOne * 0.1
           #expect(value.isInteger)
       }
       
       // MARK: - clamped Tests
       
       @Test("clamped correctly returns the value when within range")
       func testClampedWithValueInRange() throws {
           let value = 5.5
           #expect(value.clamped(to: 0.0...10.0) == 5.5)
       }
       
       @Test("clamped correctly returns the upper bound when value exceeds it")
       func testClampedWithValueExceedingUpperBound() throws {
           let value = 15.2
           #expect(value.clamped(to: 0.0...10.0) == 10.0)
       }
       
       @Test("clamped correctly returns the lower bound when value is below it")
       func testClampedWithValueBelowLowerBound() throws {
           let value = -5.0
           #expect(value.clamped(to: 0.0...10.0) == 0.0)
       }
       
       // MARK: - fractionalPart Tests
       
       @Test("fractionalPart correctly returns the fractional part")
       func testFractionalPartWithFractionalValue() throws {
           let value = 3.14159
           #expect(value.fractionalPart.rounded(toPlaces: 5) == 0.14159)
       }
       
       @Test("fractionalPart correctly handles negative values")
       func testFractionalPartWithNegativeValue() throws {
           let value = -2.75
           #expect(value.fractionalPart == -0.75)
       }
       
       @Test("fractionalPart correctly handles integer values")
       func testFractionalPartWithIntegerValue() throws {
           let value = 10.0
           #expect(value.fractionalPart == 0.0)
       }
       
       // MARK: - isNotANumber Tests
       
       @Test("isNotANumber correctly identifies NaN values")
       func testIsNotANumberWithNaNValue() throws {
           let value = Double.nan
           #expect(value.isNotANumber)
       }
       
       @Test("isNotANumber correctly identifies non-NaN values")
       func testIsNotANumberWithNonNaNValue() throws {
           let value = 5.0
           #expect(!value.isNotANumber)
       }
       
       // MARK: - isInfiniteValue Tests
       
       @Test("isInfiniteValue correctly identifies positive infinity")
       func testIsInfiniteValueWithPositiveInfinity() throws {
           let value = Double.infinity
           #expect(value.isInfiniteValue)
       }
       
       @Test("isInfiniteValue correctly identifies negative infinity")
       func testIsInfiniteValueWithNegativeInfinity() throws {
           let value = -Double.infinity
           #expect(value.isInfiniteValue)
       }
       
       @Test("isInfiniteValue correctly identifies finite values")
       func testIsInfiniteValueWithFiniteValue() throws {
           let value = 5.0
           #expect(!value.isInfiniteValue)
       }
       
       // MARK: - toString Tests
       
       @Test("toString correctly converts double to string")
       func testToStringWithPositiveValue() throws {
           let value = 100.23
           #expect(value.toString == "100.23")
       }
       
       @Test("toString correctly handles negative values")
       func testToStringWithNegativeValue() throws {
           let value = -5.0
           #expect(value.toString == "-5.0")
       }
       
       // MARK: - toInt Tests
       
       @Test("toInt correctly truncates decimal part")
       func testToIntWithFractionalPart() throws {
           let value = 5.8
           #expect(value.toInt == 5)
       }
       
       @Test("toInt correctly handles negative values")
       func testToIntWithNegativeValue() throws {
           let value = -3.9
           #expect(value.toInt == -3)
       }
       
       @Test("toInt correctly handles small values")
       func testToIntWithSmallValue() throws {
           let value = 0.1
           #expect(value.toInt == 0)
       }
       
       // MARK: - roundedToInt Tests
       
       @Test("roundedToInt correctly rounds to nearest integer")
       func testRoundedToIntRoundingUp() throws {
           let value = 5.8
           #expect(value.roundedToInt() == 6)
       }
       
       @Test("roundedToInt correctly rounds down when appropriate")
       func testRoundedToIntRoundingDown() throws {
           let value = 5.2
           #expect(value.roundedToInt() == 5)
       }
       
       @Test("roundedToInt correctly handles negative values")
       func testRoundedToIntWithNegativeValue() throws {
           let value = -3.7
           #expect(value.roundedToInt() == -4)
       }
       
       // MARK: - toCGFloat Tests
       
       @Test("toCGFloat correctly converts to CGFloat")
       func testToCGFloatWithPositiveValue() throws {
           let value = 5.8
           #expect(value.toCGFloat == CGFloat(5.8))
       }
       
       @Test("toCGFloat correctly handles negative values")
       func testToCGFloatWithNegativeValue() throws {
           let value = -3.9
           #expect(value.toCGFloat == CGFloat(-3.9))
       }
       
       @Test("toCGFloat correctly handles zero")
       func testToCGFloatWithZero() throws {
           let value = 0.0
           #expect(value.toCGFloat == CGFloat(0.0))
       }
}
