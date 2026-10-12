//
//  APIError.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//


import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: "The URL is invalid"
        case .invalidResponse: "Invalid response"
        case .decoding(let error): "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error): "Network error: \(error.localizedDescription)"
        }
    }
}
