//
//  FilmsViewModelTests.swift
//  GhibliSwiftUITests
//
//  Created by Itesh Dutt on 2026-10-11.
//

import Foundation
import Testing
import Foundation
@testable import GhibliSwiftUI


@Suite @MainActor
struct FilmsViewModelTests {
    
    @Test
    func initializationState() {
        // Arrange
        let mockService = MockGhibliService()
        let mockRouter = MockRouter()
        
        // Act
        let viewModel = FilmsViewModel(service: mockService, coordinator: mockRouter)
        
        #expect(viewModel.state == ViewState.loading)
        #expect(viewModel.films.isEmpty)
    }

    @Test
    func fetchSuccess() async {
        // Arrange
        let mockService = MockGhibliService()
        let mockRouter = MockRouter()
        
        let viewModel = FilmsViewModel(service: mockService, coordinator: mockRouter)
        
        // Act
        await viewModel.fetch()
        
        // Assert
        #expect(viewModel.state == ViewState.successful)
        #expect(viewModel.films.count == 1)
    }

    @Test
    func fetchFailure() async {
        // Arrange
        let mockService = MockGhibliService()
        let mockRouter = MockRouter()
        
        mockService.stubbedError = APIError.invalidResponse
        let viewModel = FilmsViewModel(service: mockService, coordinator: mockRouter)
        
        // Act
        await viewModel.fetch()
        
        // Assert
        #expect(viewModel.state == ViewState.error)
        #expect(viewModel.films.isEmpty)
    }

    @Test
    func didTapCardTriggersNavigation() {
        // Arrange
        let mockService = MockGhibliService()
        let mockRouter = MockRouter()
        let viewModel = FilmsViewModel(service: mockService, coordinator: mockRouter)
        let targetPeopleURL = "https://vercel.app"
        
        // Act
        viewModel.didTapCard(people: targetPeopleURL)
        
        // Assert
        #expect(mockRouter.navigateCallCount == 1)
        #expect(mockRouter.lastNavigatedRoute == .details(people: targetPeopleURL))
        #expect(mockRouter.path.contains(.details(people: targetPeopleURL)))
    }
}
