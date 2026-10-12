//
//  NetworkSession.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-12.
//

import Foundation

protocol NetworkSession: Sendable {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
