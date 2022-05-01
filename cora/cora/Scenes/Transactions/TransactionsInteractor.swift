import Foundation

protocol TransactionsInteracting { }

final class TransactionsInteractor {
    private let presenter: TransactionsPresenting
    private let coordinator: TransactionsCoordinating
    
    init(presenter: TransactionsPresenting, coordinator: TransactionsCoordinating) {
        self.presenter = presenter
        self.coordinator = coordinator
    }
}

extension TransactionsInteractor: TransactionsInteracting { }
