import UIKit

enum PasswordFactory {
    static func make() -> UIViewController {
        let presenter: PasswordPresenting = PasswordPresenter()
        let coordinator: PasswordCoordinating = PasswordCoordinator()
        let interactor: PasswordInteracting = PasswordInteractor(coordinator: coordinator, presenter: presenter)
        
        let controller = PasswordViewController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        
        return controller
    }
}
