import UIKit

protocol CPFControllerDisplaying: AnyObject {
    func setNextButtonEnabled(_ isEnabled: Bool)
}

final class CPFViewController: UIViewController {
    private lazy var greetingsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CPFText.greetingsTitle.localized
        label.font = Fonts.primary(size: 16)
        label.textColor = Colors.gray1
        return label
    }()
    
    private lazy var inputTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CPFText.inputTitle.localized
        label.font = Fonts.primaryBold(size: 22)
        label.textColor = Colors.grayOff
        return label
    }()
    
    private lazy var CPFtextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.textColor = Colors.primary
        textField.tintColor = Colors.primary
        textField.delegate = self
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greetingsTitleLabel, inputTitleLabel, CPFtextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.backgroundColor = button.isEnabled ? Colors.primary : Colors.gray2
        button.titleLabel?.font = Fonts.primary(size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(CPFText.buttonTitle.localized, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "right-disabled-arrow"), for: .normal)
        button.layer.cornerRadius = 12
        button.imageEdgeInsets.left = 150
        button.titleEdgeInsets.right = 150
        button.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        return button
    }()
    
    var bottomButtonConstraint: NSLayoutConstraint?
    private let interactor: CPFInteracting
    
    init(interactor: CPFInteracting) {
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
    
    func setupNavigationAppearance() {
        title = CPFText.title.localized
        navigationController?.navigationBar.tintColor = Colors.primary
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.gray1, .font: Fonts.primary(size: 14)]
    }
    
    func setupViews() {
        setupNavigationAppearance()
        view.backgroundColor = Colors.background
        view.addSubview(rootStackView)
        view.addSubview(nextButton)
    }
    
    func keyboardConfiguration() {
        CPFtextField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            rootStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            rootStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 16),
            
            nextButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        bottomButtonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        bottomButtonConstraint?.isActive = true
    }
}

@objc extension CPFViewController {
    func nextStep() {
        print("FOI")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomButtonConstraint?.constant =  -keyboardHeight.height - 20
            UIView.animate(withDuration: 0.5) { [weak self] in
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

extension CPFViewController: CPFControllerDisplaying {
    func setNextButtonEnabled(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? Colors.primary : Colors.gray2
    }
}

extension CPFViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       var appendString = ""
        if range.length == 0 {
            switch range.location {
            case 3:
                appendString = "."
            case 7:
                appendString = "."
            case 11:
                appendString = "-"
            default:
                break
            }
        }
        
       textField.text?.append(appendString)
        interactor.validateCPF(text: textField.text ?? "")
        
        if textField.text?.count ?? 0 > 13 && range.length == 0 {
            return false
        }
        
        return true
    }
}
