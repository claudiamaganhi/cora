import UIKit

struct PrimaryButton {
    private static var buttonConfig: UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = Colors.primary
        config.baseBackgroundColor =  Colors.background
        config.cornerStyle = .large
        config.imagePlacement = .trailing
        config.imagePadding = 170
        return config
    }
    
    private static var button: UIButton {
        let button = UIButton(configuration: buttonConfig, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

extension PrimaryButton {
    static func make() -> UIButton {
        return button
    }
}
