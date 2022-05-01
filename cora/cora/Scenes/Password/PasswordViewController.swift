import UIKit

protocol PasswordControllerDisplaying: AnyObject {
    func toggleHidePassword(shouldHide: Bool)
    func setNextButtonEnabled(_ isEnabled: Bool)
}

final class PasswordViewController: UIViewController {
    private lazy var eyeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.primary
        imageView.image = UIImage(named: "eye-hidden")
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = PasswordText.inputTitle.localized
        label.font = Fonts.primaryBold(size: 22)
        label.textColor = Colors.grayOff
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = Colors.primary
        textField.tintColor = Colors.primary
        textField.delegate = self
        textField.font = Fonts.primary(size: 16)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTextField, eyeImageView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(PasswordText.forgotPasswordTitle.localized, for: .normal)
        button.setTitleColor(Colors.primary, for: .normal)
        button.titleLabel?.font = Fonts.primary(size: 14)
        button.addTarget(self, action: #selector(forgotPassordTapped), for: .touchUpInside)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var rootStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel, passwordStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.backgroundColor = button.isEnabled ? Colors.primary : Colors.gray2
        button.titleLabel?.font = Fonts.primary(size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(PasswordText.buttonTitle.localized, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "right-disabled-arrow"), for: .normal)
        button.layer.cornerRadius = 12
        button.imageEdgeInsets.left = 150
        button.titleEdgeInsets.right = 150
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return button
    }()
    
    var bottomButtonConstraint: NSLayoutConstraint?
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
        setupViews()
        setupConstraints()
        keyboardConfiguration()
    }
    
    func setupViews() {
        setupNavigationAppearance()
        view.backgroundColor = Colors.background
        view.addSubview(rootStackView)
        view.addSubview(forgotPasswordButton)
        view.addSubview(nextButton)
        view.addSubview(eyeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            rootStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: rootStackView.bottomAnchor, constant: 34),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            
            nextButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
            
            eyeButton.leadingAnchor.constraint(equalTo: eyeImageView.leadingAnchor),
            eyeButton.trailingAnchor.constraint(equalTo: eyeImageView.trailingAnchor),
            eyeButton.topAnchor.constraint(equalTo: eyeImageView.topAnchor),
            eyeButton.bottomAnchor.constraint(equalTo: eyeImageView.bottomAnchor)
        ])
        
        bottomButtonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        bottomButtonConstraint?.isActive = true
    }
    
    func setupNavigationAppearance() {
        title = PasswordText.title.localized
        navigationController?.navigationBar.tintColor = Colors.primary
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.gray1, .font: Fonts.primary(size: 14)]
        navigationController?.navigationBar.backgroundColor = Colors.gray4
    }
    
    func keyboardConfiguration() {
        passwordTextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

@objc extension PasswordViewController {
    func nextStep() {
        interactor.showTransactions()
    }
    
    func eyeButtonTapped() {
        interactor.toggleHidePassword()
    }
    
    func forgotPassordTapped() {
        interactor.showResetPassword()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomButtonConstraint?.constant =  -keyboardHeight.height - 20
            UIView.animate(withDuration: 0) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        bottomButtonConstraint?.constant =  -34
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

extension PasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let password = textField.text,
            let rangeOfTextToReplace = Range(range, in: password) else {
                return false
        }
        
        interactor.validatePassword(string)
        let substringToReplace = password[rangeOfTextToReplace]
        let count = password.count - substringToReplace.count + string.count
        return count <= 6
    }
}

extension PasswordViewController: PasswordControllerDisplaying {
    func toggleHidePassword(shouldHide: Bool) {
        passwordTextField.isSecureTextEntry = shouldHide
    }
    
    func setNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? Colors.primary : Colors.gray2
    }
}
