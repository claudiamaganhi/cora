import UIKit

protocol TransactionsControllerDisplaying: AnyObject { }

final class TransactionsViewController: UIViewController {
    private let items = ["Tudo", "Entrada", "Saída", "Futuro"]
   
    private lazy var transactionSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: items)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.setTitleTextAttributes([.foregroundColor: Colors.gray1, .font: Fonts.primary(size: 14)], for: .normal)
        segment.setTitleTextAttributes([.foregroundColor: Colors.primary, .font: Fonts.primaryBold(size: 14)], for: .selected)
        segment.selectedSegmentIndex = 0
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segment.addUnderlineForSelectedSegment()
        return segment
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "filter"), for: .normal)
        return button
    }()
    
    private lazy var transactionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionSegment, filterButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupViews() {
        view.backgroundColor = Colors.background
        view.addSubview(transactionsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            transactionsStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            transactionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            transactionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            transactionsStackView.heightAnchor.constraint(equalToConstant: 44),
            
            filterButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

@objc extension TransactionsViewController {
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        sender.changeUnderlinePosition()
        switch sender.selectedSegmentIndex {
        case 0:
            print("1")
        case 1:
            print("2")
        default:
            print("mudou")
        }
    }
}

extension TransactionsViewController: TransactionsControllerDisplaying { }
