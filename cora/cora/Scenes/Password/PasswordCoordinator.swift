import UIKit

protocol PasswordCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class PasswordCoordinator: PasswordCoordinating {
    weak var viewController: UIViewController?
}
