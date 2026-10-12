//
//  GhibliServiceTests.swift
//  GhibliSwiftUITests
//
//  Created by Itesh Dutt on 2026-10-12.
//

import Testing
import Foundation
@testable import GhibliSwiftUI

@Suite
struct GhibliServiceTests {
    
    @Test
    func fetchFilmsSuccess() async throws {
        // Arrange
        let mockSession = MockNetworkSession()
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else{
            Issue.record("Expected service error")
            return
        }
        
        let data = try? Data(contentsOf: url)
        mockSession.mockData = data!
        let service = GhibliService(session: mockSession)
        
        let films = try await service.fetchFilms()
        
        // Assert
        #expect(films.count == 2)
        #expect(films[0].title == "Castle in the Sky")
        #expect(mockSession.requestedURL?.absoluteString == "https://ghibliapi.vercel.app/films")
    }
    
    @Test
    func fetchFilmsApiFailed() async {
        // Arrange
        let mockSession = MockNetworkSession()
        mockSession.mockStatusCode = 404
        let service = GhibliService(session: mockSession)
        do {
            _ = try await service.fetchFilms()
            Issue.record("Expected service error")
        } catch {
            #expect(error.localizedDescription == "Invalid response")
        }
    }
}
