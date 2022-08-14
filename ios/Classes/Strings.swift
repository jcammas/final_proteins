
import Foundation

extension String {
    var condensed: String {
            return replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
        }
}