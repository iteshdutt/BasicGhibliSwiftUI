//
//  ContentView.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import SwiftUI

struct ContentView: View {
    @State private var router = AppRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            FilmListView(viewModel: FilmsViewModel(coordinator: router))
                .navigationDestination(for: AppRoute.self) { route in
                    destinationView(for: route)
                }
        }
        .environment(router)
    }
    
    @ViewBuilder
    private func destinationView(for route: AppRoute) -> some View {
        switch route {
        case .details(let people):
            PersonView(viewModel: PersonViewModel(people: people))
        }
    }
}

#Preview {
    ContentView()
}
