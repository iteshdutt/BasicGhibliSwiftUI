//
//  AppRoute.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation
import SwiftUI

enum AppRoute: Hashable, Identifiable {
    case details(people: String)
    
    var id: String {
        switch self {
        case .details: "PersonDetailsView"
        }
    }
}
