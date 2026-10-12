//
//  RunOnceModifier.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-12.
//

import SwiftUI

struct RunOnceModifier: ViewModifier {
    
    @State private var hasRunTask = false
    let action: () async -> Void
    
    func body(content: Content) -> some View {
        content
            .task {
                if !hasRunTask {
                    hasRunTask = true
                    await Task.yield()
                    await action()
                }
            }
    }
}

extension View {
    public func runOnceTask(_ action: @escaping @MainActor @Sendable ()  async -> Void) -> some View {
        self.modifier(RunOnceModifier(action: action))
    }
}
