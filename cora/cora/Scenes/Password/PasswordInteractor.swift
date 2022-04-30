import Foundation

protocol PasswordInteracting { }

final class PasswordInteractor {
    private let coordinator: PasswordCoordinating
    private let presenter: PasswordPresenting
    
    init(coordinator: PasswordCoordinating, presenter: PasswordPresenting) {
        self.coordinator = coordinator
        self.presenter = presenter
    }
}

extension PasswordInteractor: PasswordInteracting { }
