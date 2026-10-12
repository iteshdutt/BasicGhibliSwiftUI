//
//  Person.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//


import Foundation

struct Person: Codable, Identifiable, Equatable, Sendable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String
    enum CodingKeys: String, CodingKey {
        case id, name, gender, age, films, species, url
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
    }
}
