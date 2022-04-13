import UIKit

enum Fonts {
    static func primary(size: CGFloat) -> UIFont {
        UIFont(name: "Avenir Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func primaryBold(size: CGFloat) -> UIFont {
        UIFont(name: "Avenir Heavy", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }

}
