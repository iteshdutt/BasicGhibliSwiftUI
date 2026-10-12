//
//  FilmListView.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import SwiftUI


struct FilmListView<ViewModel: FilmsViewModelProtocol>: View {
    // Hold the injected view model generically
    @State var viewModel: ViewModel
    
    @ViewBuilder private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView {
                Text("Loading...")
            }
        case .successful:
            List(viewModel.films) { film in
                FilmCardView(film: film, onTapAction: { people in
                    viewModel.didTapCard(people: people)
                })
                
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            
        case .error:
            Text("Error. Please try again later")
                .foregroundStyle(.pink)
        }
    }
    
    var body: some View {
        content
            .runOnceTask {
                await viewModel.fetch()
            }
    }
}
