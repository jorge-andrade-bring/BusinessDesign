//
//  Created by Backbase R&D B.V. on 19/02/2019.
//

import UIKit

// MARK: - Style extensions

extension BBButton {
    public enum Predefined {
        case light
        case dark
        case lightText

        var style: (AppTheme) -> (BBButton) -> Void {
            switch self {
            case .light: return { $0.style(for: \.lightButton) }
            case .lightText: return { $0.style(for: \.lightTextButton) }
            case .dark:  return { $0.style(for: \.darkButton) }
            }
        }
    }
}

// MARK: - Size extensions

extension BBButton {
    public enum Size {
        case small
        case large
        case text

        var style: (AppTheme) -> (BBButton) -> Void {
            switch self {
            case .small: return { $0.style(for: \.smallButton) }
            case .large: return { $0.style(for: \.largeButton) }
            case .text: return { $0.style(for: \.textButton) }
            }
        }
    }
}

// MARK: - Rounding extensions

extension BBButton {
    public enum Rounding {
        case none
        case full
        case custom(CGFloat)

        var style: (BBButton) -> Void {
            switch self {
            case .none:
                return cornerRadiusStyle(radius: 0)
            case .full:
                return { $0 |> cornerRadiusStyle(radius: $0.intendedSize.height / 2) }
            case .custom(let rounding):
                return cornerRadiusStyle(radius: rounding)
            }
        }
    }
}

// MARK: - Convenience initializers

extension BBButton {
    public convenience init(theme: AppTheme = BaseTheme,
                            style: BBButton.Predefined,
                            size: BBButton.Size,
                            configuration: (BBButton) -> Void) {
        self.init(theme: theme, style: style, size: size, rounding: .full)
        configuration(self)
    }

    public convenience init(theme: AppTheme = BaseTheme,
                            style: BBButton.Predefined,
                            size: BBButton.Size) {
        self.init(theme: theme, style: style, size: size, rounding: .full)
    }

    public convenience init(theme: AppTheme = BaseTheme,
                            style: BBButton.Predefined,
                            size: BBButton.Size,
                            rounding: BBButton.Rounding = .full) {
        let buttonStyle =
            theme
            |> theme.baseButton
            <> size.style
            <> style.style

        let indicatorStyle =
            BBLoadingIndicator.Predefined(style).style(theme)
            <> BBLoadingIndicator.Size(size).style(theme)

        self.init(style: buttonStyle, loadingIndicatorStyle: indicatorStyle)
        rounding.style(self)
    }
}
