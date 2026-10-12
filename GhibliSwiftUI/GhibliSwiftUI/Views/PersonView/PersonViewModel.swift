//
//  PersonViewModel.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation
import Foundation
import Observation

@MainActor protocol PersonViewModelProtocol {
    var state: ViewState { get }
    var person: Person? { get }
    func fetch() async
}

@Observable
class PersonViewModel: PersonViewModelProtocol {

    private(set) var state: ViewState = .loading
    @ObservationIgnored private(set) var person: Person?
    
    private let service: GhibliServiceProtocol
    private let people: String

    init(service: GhibliServiceProtocol = GhibliService(), people: String) {
        self.service = service
        self.people = people
    }
    func fetch() async {
        state = .loading
        do {
            
            person = try await service.fetchPeople(from: people)
            state = .successful
        } catch  {
            state = .error
        }
    }
}
