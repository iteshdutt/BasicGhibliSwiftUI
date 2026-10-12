//
//  AsyncIconView.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//

import SwiftUI

import SwiftUI

struct AsyncIconView: View {
    private let url: URL?
    private let size: CGFloat

    init(url: URL?, size: CGFloat) {
        self.url = url
        self.size = size
    }
    
    var body: some View {
        if let url {
            LoadableIcon(url: url, size: size)
                .id(url)
        }
    }
}

private struct LoadableIcon: View {
    let url: URL
    let size: CGFloat
    
    @State private var loadFailed = false
    var body: some View {
        if !loadFailed {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .border(Color.black.opacity(0.3), width: 1)                    
                case .failure:
                    EmptyView()
                        .task {
                            loadFailed = true
                        }
                default:
                    ProgressView()
                        .frame(width: size, height: size)
                        .background(Color(.systemGroupedBackground))
                }
            }
        }
    }
}
