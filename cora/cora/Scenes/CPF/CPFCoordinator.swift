import UIKit

protocol CPFCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
}

final class CPFCoordinator: CPFCoordinating {
    weak var viewController: UIViewController?
}
