//
//  Optional+ExtensionTest.swift
//  ModKit
//
//  Created by Siva Sankar on 19/05/25.
//

import Foundation
import ModKit
import Testing

@Suite("Optional Extension Tests")
struct OptionalExtensionTests {

    // MARK: - Boolean Properties Tests

    @Test("isNil returns true for nil values")
    func testIsNil() {
        let nilValue: String? = nil
        let nonNilValue: String? = "Hello"

        #expect(nilValue.isNil)
        #expect(!nonNilValue.isNil)
    }

    @Test("isSome returns true for non-nil values")
    func testIsSome() {
        let nilValue: Int? = nil
        let nonNilValue: Int? = 42

        #expect(!nilValue.isSome)
        #expect(nonNilValue.isSome)
    }

    // MARK: - Or Method Tests

    @Test("or returns value when optional is not nil")
    func testOrWithNonNilValue() {
        let value: Double? = 3.14

        #expect(value.or(0.0) == 3.14)
    }

    @Test("or returns default value when optional is nil")
    func testOrWithNilValue() {
        let value: Double? = nil

        #expect(value.or(0.0) == 0.0)
    }

    // MARK: - IfSome Method Tests

    @Test("ifSome executes closure for non-nil value")
    func testIfSomeWithNonNilValue() {
        let value: String? = "Test"
        var wasExecuted = false

        value.ifSome { str in
            wasExecuted = true
            #expect(str == "Test")
        }

        #expect(wasExecuted)
    }

    @Test("ifSome doesn't execute closure for nil value")
    func testIfSomeWithNilValue() {
        let value: String? = nil
        var wasExecuted = false

        value.ifSome { _ in
            wasExecuted = true
        }

        #expect(!wasExecuted)
    }

    // MARK: - IfNil Method Tests

    @Test("ifNil executes closure for nil value")
    func testIfNilWithNilValue() {
        let value: Int? = nil
        var wasExecuted = false

        value.ifNil {
            wasExecuted = true
        }

        #expect(wasExecuted)
    }

    @Test("ifNil doesn't execute closure for non-nil value")
    func testIfNilWithNonNilValue() {
        let value: Int? = 42
        var wasExecuted = false

        value.ifNil {
            wasExecuted = true
        }

        #expect(!wasExecuted)
    }

    // MARK: - Then Method Tests

    @Test("then executes some closure for non-nil value")
    func testThenWithNonNilValue() {
        let value: Int? = 42

        let result = value.then(
            { $0 * 2 },
            else: 0
        )

        #expect(result == 84)
    }

    @Test("then executes none closure for nil value")
    func testThenWithNilValue() {
        let value: Int? = nil

        let result = value.then(
            { $0 * 2 },
            else: 0
        )

        #expect(result == 0)
    }

    @Test("then with different return types")
    func testThenWithDifferentReturnTypes() {
        let value: Int? = 42

        let result = value.then(
            { "Number: \($0)" },
            else: "No value"
        )

        #expect(result == "Number: 42")
    }
}
