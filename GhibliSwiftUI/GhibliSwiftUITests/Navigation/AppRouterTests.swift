//
//  AppRouterTests.swift
//  GhibliSwiftUITests
//
//  Created by Itesh Dutt on 2026-10-12.
//

import Testing
import Foundation
import SwiftUI
@testable import GhibliSwiftUI

@Suite
@MainActor
struct AppRouterTests {
    
    @Test
    func testInitialState() {
        let sut = AppRouter()
        
        #expect(sut.path.isEmpty)
        #expect(sut.presentedSheet == nil)
    }
    
    @Test
    func testNavigateAppendsToPath() {
        let sut = AppRouter()
        let targetRoute = AppRoute.details(people: "people")
        
        sut.navigate(to: targetRoute)
        
        #expect(sut.path.count == 1)
        #expect(sut.path.first == targetRoute)
    }
    
    @Test
    func testPopOnEmptyStackDoesNothing() {
        let sut = AppRouter()
        
        sut.pop()
        
        #expect(sut.path.isEmpty)
    }
    
    @Test
    func testPopRemovesLastElement() {
        let sut = AppRouter()
        sut.navigate(to: .details(people: "1"))
        sut.navigate(to: .details(people: "2"))
        
        sut.pop()
        
        #expect(sut.path.count == 1)
        #expect(sut.path.last == .details(people: "1"))
    }
    
    @Test
    func testPopToRootClearsAllElements() {
        let sut = AppRouter()
        sut.navigate(to: .details(people: "1"))
        sut.navigate(to: .details(people: "2"))
        sut.navigate(to: .details(people: "3"))
        
        sut.popToRoot()
        
        #expect(sut.path.isEmpty)
    }
    
    @Test
    func testPresentSheetSetsState() {
        let sut = AppRouter()
        let targetSheet = AppRoute.details(people: "sheet_url")
        
        sut.presentSheet(targetSheet)
        
        #expect(sut.presentedSheet == targetSheet)
    }
    
    @Test
    func testDismissSheetClearsState() {
        let sut = AppRouter()
        sut.presentSheet(.details(people: "sheet_url"))
        
        sut.dismissSheet()
        
        #expect(sut.presentedSheet == nil)
    }
}
