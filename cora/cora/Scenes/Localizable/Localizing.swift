import Foundation

protocol Localizing: RawRepresentable {
    var localized: String { get }
}

extension Localizing where RawValue == String {
    var localized: String {
        NSLocalizedString(rawValue, comment: rawValue)
    }
}
