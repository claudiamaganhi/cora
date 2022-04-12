import UIKit

struct SecondaryButton {
    private static var button: UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.primary
        button.titleLabel?.font = Fonts.primaryLight(size: 14)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }
}

extension SecondaryButton {
    static func make() -> UIButton {
        button
    }
}
