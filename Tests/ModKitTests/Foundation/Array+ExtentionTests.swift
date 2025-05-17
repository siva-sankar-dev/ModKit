//
//  Array+ExtentionTests.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import ModKit
import Testing

@Suite("Array Extention Tests")
struct ArrayExtentionTests {

    //MARK: - isNotEmpty Tests
    @Test(
        "isNotEmpty returns true for non-empty arrays"
    )
    func arrayIsNotEmptyTest() throws {
        let notEmptyArray = [1, 4, 5]

        #expect(notEmptyArray.isNotEmpty)
    }

    @Test("isNotEmpty returns false for empty arra")
    func arraysIsNotEmptyWithEmptyArrayTest() async throws {
        let emptyArray: [Int] = []

        #expect(!emptyArray.isNotEmpty)
    }

    //MARK: - chunked Tests
    @Test("chunked creates correct sized array chunks")
    func chunkedWithEvenDivisionTest() throws {
        let array = [2, 4, 5, 6, 7, 8]
        let chunks = array.chunked(into: 2)

        #expect(chunks.count == 3)
        #expect(chunks[0] == [2, 4])
        #expect(chunks[1] == [5, 6])
        #expect(chunks[2] == [7, 8])

    }

    @Test("chunks handle reminder elements correctly")
    func chunkedWithReminderTest() throws {
        let array = [4, 5, 2, 5, 6]
        let chunks = array.chunked(into: 2)

        #expect(chunks.count == 3)
        #expect(chunks[0] == [4, 5])
        #expect(chunks[1] == [2, 5])
        #expect(chunks[2] == [6])
    }

    @Test("chunked handles chunk size larger than array")
    func chunkedWithLargeChunkSizeTest() throws {
        let array = [3, 4]
        let chunks = array.chunked(into: 5)

        #expect(chunks.count == 1)
        #expect(chunks[0] == [3, 4])
    }

    @Test("chuked returs empty array for empty input")
    func chunkedWithEmptyArrayTest() throws {
        let array: [Int] = []
        let chunks = array.chunked(into: 10)

        #expect(chunks.isEmpty)
    }

    //MARK: - removeDuplicates Tests
    @Test("removeDuplicates preserves the order while removing the duplicates")
    func removeDuplicatesWhilePreservingOrderTest() throws {
        let array = [1, 2, 2, 3, 1, 4, 5, 3]
        let unique = array.removeDuplicates()

        #expect(unique == [1, 2, 3, 4, 5])
    }

    @Test("removeDuplicates handles empty array")
    func removeDuplicatesWithEmptyArrayTest() throws {
        let array: [Int] = []
        let unique = array.removeDuplicates()

        #expect(unique.isEmpty)
    }

    @Test("removeDuplicates hanlde array with no duplicates")
    func removeDuplicatesWithNoDuplicatesTest() async throws {
        let array = [1, 2, 3, 4, 5]
        let unique = array.removeDuplicates()

        #expect(unique == array)
        #expect(unique == [1, 2, 3, 4, 5])
    }

    @Test("remove duplicates hanldes string array")
    func removeDuplicatesWithStrngsTest() async throws {
        let array = ["apple", "banana", "apple", "cherry", "banana"]
        let unique = array.removeDuplicates()

        #expect(unique == ["apple", "banana", "cherry"])
    }

    @Test("removeDuplicates works with custom hashable types")
    func remvoeDuplicatesWithCustomHashableTypeTest() async throws {
        struct Dog: Hashable {
            let name: String
            let age: Int
        }

        let dog1 = Dog(name: "Linda", age: 8)
        let dog2 = Dog(name: "Rex", age: 5)
        let dog3 = Dog(name: "Linda", age: 8)

        let array = [dog1, dog2, dog3]
        let unique = array.removeDuplicates()

        #expect(unique.count == 2)
        #expect(unique.contains(where: { $0.name == "Linda" && $0.age == 8 }))
        #expect(unique.contains(where: { $0.name == "Rex" && $0.age == 5 }))
    }

}
