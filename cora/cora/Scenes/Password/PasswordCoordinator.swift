import UIKit

protocol PasswordCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func showTransactions()
    func showResetPassword()
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

extension PasswordCoordinator: PasswordCoordinating {
    func showTransactions() {
        viewController?.show(TransactionsFactory.make(), sender: nil)
    }
    
    func showResetPassword() {
        guard let url = URL(string: "https://www.cora.com.br") else { return }
        UIApplication.shared.open(url, options: [:])
    }
}
