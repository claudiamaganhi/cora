import UIKit

protocol TransactionsCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class TransactionsCoordinator: TransactionsCoordinating {
    weak var viewController: UIViewController?
}

extension TransactionsCoordinator { }
