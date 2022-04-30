import UIKit

enum CPFFactory {
    static func make() -> UIViewController {
        let coordinator: CPFCoordinating = CPFCoordinator()
        let presenter: CPFPresenting = CPFPresenter()
        let interactor: CPFInteracting = CPFInteractor(coordinator: coordinator, presenter: presenter)
        let controller = CPFViewController(interactor: interactor)
        
        coordinator.viewController = controller
        presenter.viewController = controller
        
        return controller
    }
}
