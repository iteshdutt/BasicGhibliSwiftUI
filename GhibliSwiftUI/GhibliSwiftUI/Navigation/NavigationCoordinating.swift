//
//  NavigationCoordinating.swift
//  GhibliSwiftUI
//
//  Created by Itesh Dutt on 2026-10-11.
//


import SwiftUI

@MainActor
protocol NavigationCoordinating: AnyObject {
    var path: [AppRoute] { get set }
    var presentedSheet: AppRoute? { get set }
    
    func navigate(to route: AppRoute)
    func pop()
    func popToRoot()
    func presentSheet(_ route: AppRoute)
    func dismissSheet()
}
