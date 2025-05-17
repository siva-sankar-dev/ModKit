//
//  Int+ExtentionTests.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Testing
import ModKit
import CoreGraphics

@Suite("Int Extension Tests")
struct IntExtensionTests {
    
    // MARK: - isZero Tests
    
    @Test("isZero correctly identifies zero values")
    func testIsZero() {
        let zero = 0
        #expect(zero.isZero)
        
        let positive = 5
        #expect(!positive.isZero)
        
        let negative = -3
        #expect(!negative.isZero)
    }
    
    // MARK: - isEven/isOdd Tests
    
    @Test("isEven and isOdd work correctly")
    func testEvenOdd() {
        let evenNumbers = [2, 4, -6, 0]
        let oddNumbers = [1, 3, -5, 7]
        
        for number in evenNumbers {
            #expect(number.isEven)
            #expect(!number.isOdd)
        }
        
        for number in oddNumbers {
            #expect(number.isOdd)
            #expect(!number.isEven)
        }
    }
    
    // MARK: - isPositive/isNegative Tests
    
    @Test("isPositive and isNegative work correctly")
    func testPositiveNegative() {
        let positives = [1, 10, 100]
        let negatives = [-1, -10, -100]
        let zero = 0
        
        for number in positives {
            #expect(number.isPositive)
            #expect(!number.isNegative)
        }
        
        for number in negatives {
            #expect(number.isNegative)
            #expect(!number.isPositive)
        }
        
        #expect(!zero.isPositive)
        #expect(!zero.isNegative)
    }
    
    // MARK: - absoluteValue Tests
    
    @Test("absoluteValue returns correct value")
    func testAbsoluteValue() {
        #expect((-10).absoluteValue == 10)
        #expect(5.absoluteValue == 5)
        #expect(0.absoluteValue == 0)
    }
    
    // MARK: - digits Tests
    
    @Test("digits returns correct array")
    func testDigits() {
        #expect(123.digits == [1, 2, 3])
        #expect(0.digits == [0])
        #expect((-456).digits == [4, 5, 6])
        #expect(1000.digits == [1, 0, 0, 0])
    }
    
    // MARK: - digitCount Tests
    
    @Test("digitCount returns correct count")
    func testDigitCount() {
        #expect(12345.digitCount == 5)
        #expect(0.digitCount == 1)
        #expect((-987).digitCount == 3)
        #expect(1.digitCount == 1)
        #expect(999999.digitCount == 6)
    }
    
    // MARK: - times Tests
    
    @Test("times executes correct number of times")
    func testTimes() {
        var count = 0
        3.times { count += 1 }
        #expect(count == 3)
        
        var indexSum = 0
        5.times { index in indexSum += index }
        #expect(indexSum == 10) // 0+1+2+3+4
        
        var negativeCount = 0
        (-2).times { negativeCount += 1 }
        #expect(negativeCount == 0)
    }
    
    // MARK: - isPrime Tests
    
    @Test("isPrime correctly identifies prime numbers")
    func testIsPrime() {
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23]
        let nonPrimes = [4, 6, 8, 9, 10, 12, 14, 15]
        let edgeCases = [0, 1, -1, -5]
        
        for prime in primes {
            #expect(prime.isPrime)
        }
        
        for nonPrime in nonPrimes {
            #expect(!nonPrime.isPrime)
        }
        
        for cases in edgeCases {
            #expect(!cases.isPrime)
        }
    }
    
    // MARK: - Conversion Tests
    
    @Test("Conversion properties work correctly")
    func testConversions() {
        let number = 42
        #expect(number.toString == "42")
        #expect(number.toDouble == 42.0)
        #expect(number.toCGFloat == 42.0)
        
        let negative = -7
        #expect(negative.toString == "-7")
        #expect(negative.toDouble == -7.0)
        #expect(negative.toCGFloat == -7.0)
    }
}
