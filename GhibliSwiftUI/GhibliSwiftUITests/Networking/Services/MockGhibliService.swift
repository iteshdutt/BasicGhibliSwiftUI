//
//  MockGhibliService.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation
final class MockGhibliService: GhibliServiceProtocol, @unchecked Sendable {
    var stubbedError: Error?

    func fetchPeople(from url: String) async throws -> Person {
        if let error = stubbedError {
            throw error
        }
        return try loadSampleData().people.first!
    }
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        let bundle = Bundle(for: MockGhibliService.self)
        guard let url = bundle.url(forResource: "SampleData", withExtension: "json") else {
//        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else{
            throw APIError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch {
            throw APIError.invalidURL
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        if let error = stubbedError {
            throw error
        }
        return try loadSampleData().films
    }
}
