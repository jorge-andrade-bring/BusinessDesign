//
//  Created by Backbase R&D B.V. on 16/09/2020.
//

import UIKit

public typealias IconLocator = (name: String, bundle: Bundle)

public extension UIImage {

    /// Get image with a given name name and bundle
    /// - Parameters:
    ///   - iconLocator: A tuple that has the image resource name and the bundle that the resource is
    /// - Returns: Optional `UIImage`.
    static func forIconLocator(_ iconLocator: IconLocator?) -> UIImage? {
        guard let iconLocator = iconLocator else {
            return nil
        }

        return UIImage(
            named: iconLocator.name,
            in: iconLocator.bundle,
            compatibleWith: nil
        )
    }
}
