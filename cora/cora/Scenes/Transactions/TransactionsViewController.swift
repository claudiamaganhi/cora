import UIKit

protocol TransactionsControllerDisplaying: AnyObject { }

final class TransactionsViewController: UIViewController {
    
    private let interactor: TransactionsInteracting
    
    init(interactor: TransactionsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension TransactionsViewController: TransactionsControllerDisplaying { }
