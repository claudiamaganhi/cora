import Foundation

protocol PasswordInteracting {
    func toggleHidePassword()
    func validatePassword(_ text: String)
    func showTransactions()
    func showResetPassword()
}

final class PasswordInteractor {
    private var shouldShowPassword = false
    private var password = ""
    private let coordinator: PasswordCoordinating
    private let presenter: PasswordPresenting
    
    init(coordinator: PasswordCoordinating, presenter: PasswordPresenting) {
        self.coordinator = coordinator
        self.presenter = presenter
    }
}

extension PasswordInteractor: PasswordInteracting {
    func toggleHidePassword() {
        shouldShowPassword.toggle()
        presenter.toggleHidePassword(shouldHide: shouldShowPassword)
    }
    
    func validatePassword(_ text: String) {
        if password.count < 6 {
            password.append(contentsOf: text)
        }
        
        if text == "" {
            password = String(password.dropLast())
        }
        
        presenter.setNextButtonEnabled(password.count == 6)
    }
    
    func showTransactions() {
        coordinator.showTransactions()
    }
    
    func showResetPassword() {
        coordinator.showResetPassword()
    }
}
