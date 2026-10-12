//
//  PersonView.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import SwiftUI

struct PersonView<ViewModel: PersonViewModelProtocol>: View {
    // Hold the injected view model generically
    @State var viewModel: ViewModel
    
    var body: some View {
        content
            .runOnceTask {
                await viewModel.fetch()
            }
    }
    
    @ViewBuilder private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView {
                Text("Loading...")
            }
        case .successful:
            if let person = viewModel.person {
                VStack(alignment: .leading) {
                    Text("Name - \(person.name)")
                        .font(.title3)
                        .foregroundStyle(.black)
                    Text("Gender - \(person.gender)")
                        .font(.body)
                        .foregroundStyle(.blue)

                    Text("Age - \(person.age)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)

                    Text("Hair Color - \(person.hairColor)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text("Eye Color - \(person.eyeColor)")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
        case .error:
            Text("Error. Please try again later")
                .foregroundStyle(.pink)
        }
    }
}
