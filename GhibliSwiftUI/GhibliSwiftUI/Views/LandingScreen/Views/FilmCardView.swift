//
//  FilmCardView.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import SwiftUI

struct FilmCardView: View {
    let film: Film
    let onTapAction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 24) {
                AsyncIconView(url: URL(string: film.image), size: 100)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name - \(film.title)")
                        .font(.body)
                    Text("Director - \(film.director)")
                        .font(.body)
                    if let people = film.people.first {
                        Button {
                            onTapAction(people)
                        } label: {
                            Text("Cast details")
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                                .underline()
                        }
                    } else {
                        Text("No cast available")
                            .font(.subheadline)
                    }
                }
            }
            Divider().padding(.horizontal, .zero)
        }
        .padding([.top, .horizontal], 16)
    }
}
