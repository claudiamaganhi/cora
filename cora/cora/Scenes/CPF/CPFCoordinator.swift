import UIKit

protocol CPFCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func showPasswordScreen()
}

final class CPFCoordinator: CPFCoordinating {
    weak var viewController: UIViewController?
    
    func showPasswordScreen() {
        viewController?.show(PasswordFactory.make(), sender: nil)
    }
}
