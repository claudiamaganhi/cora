import Foundation

protocol CPFInteracting {
    func validateCPF(text: String)
    func showPasswordScreen()
}

final class CPFInteractor {
    private let coordinator: CPFCoordinating
    private let presenter: CPFPresenting
    
    init(coordinator: CPFCoordinating, presenter: CPFPresenting) {
        self.coordinator = coordinator
        self.presenter = presenter
    }
}

extension CPFInteractor: CPFInteracting {
    func validateCPF(text: String) {
        presenter.setNextButtonEnabled(text.count == 14)
    }
    
    func showPasswordScreen() {
        coordinator.showPasswordScreen()
    }
}
