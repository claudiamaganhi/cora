import UIKit

enum IntroFactory {
    static func make() -> UIViewController {
        var coordinator: IntroCoordinating = IntroCoordinator()
        let interactor: IntroInteracting = IntroInteractor(coordinator: coordinator)
        let controller = IntroViewController(interactor: interactor)
        
        coordinator.viewController = controller
        
        return controller
    }
}
