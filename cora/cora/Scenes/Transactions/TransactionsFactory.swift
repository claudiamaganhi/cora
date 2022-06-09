import UIKit

enum TransactionsFactory {
    static func make() -> UIViewController {
        let presenter: TransactionsPresenting = TransactionsPresenter()
        let coordinator: TransactionsCoordinating = TransactionsCoordinator()
        let interactor: TransactionsInteracting = TransactionsInteractor(presenter: presenter, coordinator: coordinator)
        let controller = TransactionsViewController(interactor: interactor)
        
        presenter.viewController = controller
        coordinator.viewController = controller
        
        return controller
    }
}
