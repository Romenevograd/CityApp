import Foundation

extension String {
    var capitalized: String {
        prefix(1).capitalized + dropFirst()
    }
}
