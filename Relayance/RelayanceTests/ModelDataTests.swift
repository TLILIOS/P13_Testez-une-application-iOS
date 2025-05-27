//
//  ModelDataTests.swift
//  RelayanceTests
//
//  Created by TLiLi Hamdi on 20/05/2025.
//

import XCTest
@testable import Relayance

final class ModelDataTests: XCTestCase {
    
    func testLoadClientsFromJSON() throws {
        // Act
        let clients: [Client] = try loadJSON(from: "TestClients", as: [Client].self)
        
        // Assert
        XCTAssertEqual(clients.count, 2)
        XCTAssertEqual(clients[0].nom, "Jean Dupont")
        XCTAssertEqual(clients[1].email, "marie.martin@example.com")
    } 
    
    func testLoadEmptyClientsArray() throws {
        // Act
        let clients: [Client] = try loadJSON(from: "EmptyClients", as: [Client].self)
        
        // Assert
        XCTAssertTrue(clients.isEmpty)
    }
    
    func testLoadInvalidJSON() {
        // Act & Assert
        XCTAssertThrowsError(try loadJSON(from: "InvalidClients", as: [Client].self)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func testModelDataWithRealFile() throws {
        
        let clients: [Client] = try loadJSON(from: "TestClients", as: [Client].self)
        XCTAssertEqual(clients.count, 2)
        XCTAssertEqual(clients[0].nom, "Jean Dupont")
    }
}

extension XCTestCase {
    
    func loadJSONData(from fileName: String, bundle: Bundle? = nil) throws -> Data {
        let testBundle = bundle ?? Bundle(for: type(of: self))
        
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            throw TestError.fileNotFound(fileName)
        }
        
        return try Data(contentsOf: url)
    }
    
    func loadJSON<T: Decodable>(from fileName: String, as type: T.Type) throws -> T {
        let data = try loadJSONData(from: fileName)
        return try JSONDecoder().decode(type, from: data)
    }
    
    enum TestError: Error {
        case fileNotFound(String)
    }

}
