import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordControllerDisplaying? { get set }
}


final class PasswordPresenter {
    weak var viewController: PasswordControllerDisplaying?
}

extension PasswordPresenter: PasswordPresenting { }
