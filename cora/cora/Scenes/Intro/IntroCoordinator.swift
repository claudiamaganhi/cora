import UIKit

protocol IntroCoordinating {
    var viewController: UIViewController? { get set }
    func createAccount()
    func showStament()
}

final class IntroCoordinator: IntroCoordinating {
    weak var viewController: UIViewController?
}

extension IntroCoordinator {
    func createAccount() {
        let cpfController = CPFViewController()
        viewController?.navigationItem.backButtonTitle = ""
        viewController?.show(cpfController, sender: nil)
    }
    
    func showStament() {
        print("ir pra tela extrato")
    }
}
