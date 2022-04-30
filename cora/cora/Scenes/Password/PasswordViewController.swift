import UIKit

protocol PasswordControllerDisplaying: AnyObject { }

final class PasswordViewController: UIViewController {
    private let interactor: PasswordInteracting
    
    init(interactor: PasswordInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint

    }
}

extension PasswordViewController: PasswordControllerDisplaying { }
