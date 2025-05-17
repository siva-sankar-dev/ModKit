//
//  SpiderTests.swift
//  ModKit
//
//  Created by Siva Sankar on 17/05/25.
//

import Testing
import ModKit
import SwiftUI

@Suite("Spider Networking Tests")
struct SpiderTests {
    // MARK: - Test Configuration
    private let testURL = "https://rickandmortyapi.com/api/character"
    private let spider = Spider()
    
    // MARK: - Data Request Tests
    
    @Test("Perform GET request with completion handler - data response")
    func testGetRequestWithCompletion() async throws {
        let request = try HTTPRequest(urlString: testURL)
        spider.performRequest(request, logging: true) { result in
            switch result {
            case .success(let data):
                #expect(!data.isEmpty)
                print("Received data count: \(data.count) bytes")
            case .failure(let error):
                Issue.record("Request failed with error: \(error)")
            }
        }
    }
    
    @Test("Perform async GET request - data response")
    func testAsyncGetRequest() async throws {
        let request = try HTTPRequest(urlString: testURL)
        
        let result = await spider.performRequest(request, logging: true)
        
        switch result {
        case .success(let data):
            #expect(!data.isEmpty)
            print("Received data count: \(data.count) bytes")
        case .failure(let error):
            Issue.record("Request failed with error: \(error)")
        }
    }
    
    // MARK: - Decodable Request Tests
    
    @Test("Perform GET request with completion handler - decoded response")
    func testGetRequestWithDecoding() async throws {
        let request = try HTTPRequest(urlString: testURL)
        spider.performRequest(
            request,
            responseType: CharacterResponse.self,
            logging: true
        ) { result in
            switch result {
            case .success(let response):
                #expect(response.info.count > 0)
                #expect(response.info.pages > 0)
                print("Received \(response.info.count) characters across \(response.info.pages) pages")
                
                // Validate first character
                if let firstCharacter = response.results.first {
                    #expect(firstCharacter.id > 0)
                    #expect(!firstCharacter.name.isEmpty)
                    #expect(!firstCharacter.species.rawValue.isEmpty)
                    #expect(!firstCharacter.status.rawValue.isEmpty)
                    #expect(!firstCharacter.gender.rawValue.isEmpty)
                    #expect(!firstCharacter.image.isEmpty)
                    
                    print("First character: \(firstCharacter.name), Status: \(firstCharacter.status.rawValue)")
                } else {
                    Issue.record("No characters found in response")
                }
            case .failure(let error):
                Issue.record("Decoding failed with error: \(error)")
            }        }
    }
    
    @Test("Perform async GET request - decoded response")
    func testAsyncGetRequestWithDecoding() async throws{
        let request = try HTTPRequest(urlString: testURL)
        
        let result = await spider.performRequest(
            request,
            responseType: CharacterResponse.self,
            logging: true
        )
        
        switch result {
        case .success(let response):
            #expect(response.info.count > 0)
            #expect(response.info.pages > 0)
            print("Received \(response.info.count) characters across \(response.info.pages) pages")
            
            // Validate first character
            if let firstCharacter = response.results.first {
                #expect(firstCharacter.id > 0)
                #expect(!firstCharacter.name.isEmpty)
                #expect(!firstCharacter.species.rawValue.isEmpty)
                #expect(!firstCharacter.status.rawValue.isEmpty)
                #expect(!firstCharacter.gender.rawValue.isEmpty)
                #expect(!firstCharacter.image.isEmpty)
                
                print("First character: \(firstCharacter.name), Status: \(firstCharacter.status.rawValue)")
            } else {
                Issue.record("No characters found in response")
            }
        case .failure(let error):
            Issue.record("Decoding failed with error: \(error)")
        }
    }
    
    
    @Test("Handle decoding error with wrong type")
    func testDecodingError() async throws {
        // This request will succeed but we'll try to decode into wrong type
        let request = try HTTPRequest(urlString: testURL)
        
        struct WrongType: Decodable {
            let nonExistentField: String
        }
        
        let result = await spider.performRequest(
            request,
            responseType: WrongType.self,
            logging: true
        )
        
        switch result {
        case .success:
            Issue.record("Decoding unexpectedly succeeded with wrong type")
        case .failure(let error):
            #expect(error == .decodingFailed)
            print("Correctly received decoding error: \(error)")
        }
    }
    
    @Test("Handle invalid URL error")
    func testInvalidURL() async {
        do {
            let invalidRequest = try HTTPRequest(urlString: "invalid url")
            
            let result = await spider.performRequest(invalidRequest, logging: true)
            
            switch result {
            case .success:
                Issue.record("Request unexpectedly succeeded with invalid URL")
            case .failure(let error):
            
                print("Correctly received error for invalid URL: \(error)")
        }
        } catch {
            #expect(error as! NetworkError == NetworkError.invalidURL)
        }
    }
    
}
