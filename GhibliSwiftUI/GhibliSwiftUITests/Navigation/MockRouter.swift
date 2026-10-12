//
//  MockRouter.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//


import Foundation
import SwiftUI

@Observable
final class MockRouter: NavigationCoordinating {
    // Required protocol states
    var path: [AppRoute] = []
    var presentedSheet: AppRoute?
    
    // Test Spy variables to track interactions
    private(set) var navigateCallCount = 0
    private(set) var lastNavigatedRoute: AppRoute?
    
    private(set) var popCallCount = 0
    private(set) var popToRootCallCount = 0
    private(set) var presentSheetCallCount = 0
    private(set) var dismissSheetCallCount = 0

    func navigate(to route: AppRoute) {
        navigateCallCount += 1
        lastNavigatedRoute = route
        path.append(route)
    }
    
    func pop() {
        popCallCount += 1
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        popToRootCallCount += 1
        path.removeAll()
    }
    
    func presentSheet(_ route: AppRoute) {
        presentSheetCallCount += 1
        presentedSheet = route
    }
    
    func dismissSheet() {
        dismissSheetCallCount += 1
        presentedSheet = nil
    }
}
