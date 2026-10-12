//
//  GhibliService.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation

protocol GhibliServiceProtocol: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPeople(from url: String) async throws -> Person
}

final class GhibliService: GhibliServiceProtocol {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func fetchFilms() async throws -> [Film] {
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }
    
    func fetchPeople(from url: String) async throws -> Person {
        return try await fetch(from: url, type: Person.self)
    }
    
    private func fetch<T: Decodable>(from urlString: String, type: T.Type) async throws -> T {
        do {
            guard let url = URL(string: urlString) else {
                throw APIError.invalidURL
            }
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            return try JSONDecoder().decode(type, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}

