//
//  MockNetworkSession.swift
//  GhibliSwiftUITests
//
//  Created by Itesh Dutt on 2026-10-12.
//

import Foundation

final class MockNetworkSession: NetworkSession, @unchecked Sendable {
    var mockData: Data?
    var mockStatusCode: Int = 200
    var mockError: Error?
    private(set) var requestedURL: URL?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        requestedURL = url
        
        if let error = mockError {
            throw error
        }
        
        let response = HTTPURLResponse(
            url: url,
            statusCode: mockStatusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return (mockData ?? Data(), response)
    }
}
