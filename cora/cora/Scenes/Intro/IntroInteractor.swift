import Foundation

protocol IntroInteracting {
    func showStatment()
    func createAccount()
}

final class IntroInteractor: IntroInteracting {
    private let coordinator: IntroCoordinating
    
    init(coordinator: IntroCoordinating) {
        self.coordinator = coordinator
    }
}

extension IntroInteractor {
    func createAccount() {
        coordinator.createAccount()
    }
    
    func showStatment() {
        coordinator.showStament()
    }
}
