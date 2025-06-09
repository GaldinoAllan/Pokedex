import Foundation
import Testing
import SwiftUI
@testable import Pokedex

// MARK: - makeSUT method
fileprivate extension RouterTests {
    typealias SUT = Router
    
    func makeSUT() -> SUT {
        return Router()
    }
}

// MARK: - Tests
@MainActor
struct RouterTests {
    @Test("navigate adds destination to path")
    func navigateAddsDestinationToPath() async {
        let sut = makeSUT()
        let destination = AppDestination.pokedex
        
        sut.navigate(to: destination)
        
        #expect(sut.navigationPath.count == 1)
    }
}
