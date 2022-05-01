import Foundation

protocol TransactionsPresenting: AnyObject {
    var viewController: TransactionsControllerDisplaying? { get set }
}

final class TransactionsPresenter: TransactionsPresenting {
    weak var viewController: TransactionsControllerDisplaying?
}

extension TransactionsPresenter { }
