import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordControllerDisplaying? { get set }
    func toggleHidePassword(shouldHide: Bool)
    func setNextButtonEnabled(_ isEnabled: Bool)
}


final class PasswordPresenter {
    weak var viewController: PasswordControllerDisplaying?
}

extension PasswordPresenter: PasswordPresenting {
    func toggleHidePassword(shouldHide: Bool) {
        viewController?.toggleHidePassword(shouldHide: shouldHide)
    }
    
    func setNextButtonEnabled(_ isEnabled: Bool) {
        viewController?.setNextButtonEnabled(isEnabled)
    }
}
