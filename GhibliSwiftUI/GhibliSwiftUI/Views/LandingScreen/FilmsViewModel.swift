//
//  FilmsViewModel.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation
import Observation

@MainActor protocol FilmsViewModelProtocol {
    var state: ViewState { get }
    var films: [Film] { get }
    func fetch() async
    func didTapCard(people: String)

}

@Observable
class FilmsViewModel: FilmsViewModelProtocol {
    private let coordinator: NavigationCoordinating
    private(set) var state: ViewState = .loading
    @ObservationIgnored private(set) var films: [Film] = []
    
    private let service: GhibliServiceProtocol
    
    init(service: GhibliServiceProtocol = GhibliService(),
         coordinator: NavigationCoordinating) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func fetch() async {
        state = .loading
        do {
            let fetchedFilms = try await service.fetchFilms()
            films = fetchedFilms
            state = .successful
        } catch  {
            state = .error
        }
    }
    
    func didTapCard(people: String) {
        coordinator.navigate(to: .details(people: people))
    }
}
