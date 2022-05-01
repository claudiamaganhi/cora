import UIKit

final class IntroViewController: UIViewController {
    private lazy var introImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "intro")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.primaryBold(size: 28)
        label.text = IntroText.title.localized
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.primary(size: 28)
        label.text = IntroText.subtitle.localized
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.primary(size: 16)
        label.text = IntroText.description.localized
        label.textColor = .white
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var joinButton: UIButton = {
        let button = PrimaryButton.make()
        button.configuration?.attributedTitle = AttributedString(IntroText.joinButton.localized, attributes: AttributeContainer([.font: Fonts.primary(size: 16)]))
        button.configuration?.image = UIImage(named: "right-arrow")
        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = SecondaryButton.make()
        button.setTitle(IntroText.loginButton.localized, for: .normal)
        button.addTarget(self, action: #selector(showStatement), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [joinButton, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [introImageView, descriptionStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    private let interactor: IntroInteracting
    
    init(interactor: IntroInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        introImageView.addSubview(logoImageView)
        view.addSubview(rootStackView)
        view.addSubview(bottomStackView)
        view.backgroundColor = Colors.primary
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            logoImageView.leadingAnchor.constraint(equalTo: introImageView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logoImageView.topAnchor.constraint(equalTo: introImageView.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            loginButton.heightAnchor.constraint(equalToConstant: 48.0),
            joinButton.heightAnchor.constraint(equalToConstant: 64.0),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

@objc extension IntroViewController {
    func showStatement() {
        interactor.showStatment()
    }
    
    func createAccount() {
        interactor.createAccount()
    }
}
