import Foundation

public extension Int {
    /// Formats the integer with 3 digits and # prefix (e.g., #001, #025, #150)
    var format03: String {
        "#\(String(format: "%03d", self))"
    }
}
