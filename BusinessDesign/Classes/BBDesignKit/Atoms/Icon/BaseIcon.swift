//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

// MARK: - IconBackgroundShape

/// Defines the icon corner radius behavior
public enum IconBackgroundShape {
    /// Applies a 0 pt corner radius to the view (the default behavior, a square view)
    case square

    /// Applies a 4 pt corner radius to the view
    case extraSmall

    /// Applies a 8 pt corner radius to the view
    case small

    /// Applies a 16 pt corner radius to the view
    case medium

    /// Applies the half of the view's height corner radius to the view resulting to a circular (full rounded) shape
    case circle

    var radius: CGFloat {
        switch self {
        case .square:
            return 0
        case .extraSmall:
            return 4
        case .small:
            return 8
        case .medium:
            return 16
        case .circle:
            return 0
        }
    }
}

// MARK: - IconTintBehavior

/// Defines how the Icon Atom applies the colors to itself
public enum IconTintBehavior {
    /// When selected, the icon atom will apply the `backgroundColor` to the background view and the `foregroundColor`
    /// as the color of the image without taking into consideration the `tintColor` value.
    case none

    /// When selected the icon atom will apply the defined `tintColor` to the foreground (the tint color of the image) and apply the
    /// `backgroundColor` to the background view and ignore the `foregroundColor` configuration.
    /// `tintColor` property must be set otherwise the default system color will get applied.
    case foreground

    /// When selected the icon atom will apply the defined `tintColor` to the background (the background color of the view) and apply the
    /// `foregroundColor` to the foreground (the tint color of the image) and ignore the `backgroundColor` configuration.
    /// `tintColor` property must be set otherwise the default system color will get applied.
    case background
}

// MARK: - BaseIcon

internal protocol BaseIcon: AnyObject {

    var configuration: IconConfiguration { get }

    func setImage(_ image: UIImage?, withTintColor imageTintColor: UIColor?)
}
