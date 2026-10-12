//
//  Film.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation

import Foundation

struct Film: Codable, Identifiable, Equatable {
    let id: String
    let title: String
    let description: String
    let director: String
    
    let image: String
    let bannerImage: String
    let releaseYear: String
    let duration: String
    let score: String
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, director, image, people
        case bannerImage = "movie_banner"
        
        case releaseYear = "release_date"
        case duration = "running_time"
        case score = "rt_score"
    }
}

