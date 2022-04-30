import UIKit

protocol CPFPresenting: AnyObject {
    var viewController: CPFControllerDisplaying? { get set }
    func setNextButtonEnabled(_ isEnabled: Bool)
}

final class CPFPresenter {
    weak var viewController: CPFControllerDisplaying?
}

extension CPFPresenter: CPFPresenting {
    func setNextButtonEnabled(_ isEnabled: Bool) {
        viewController?.setNextButtonEnabled(isEnabled)
    }
}
