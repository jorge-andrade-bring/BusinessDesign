//
//  Created by Backbase R&D B.V. on 19/02/2019.
//

import Foundation

// MARK: - Style extensions

extension BBLoadingIndicator {
    public enum Predefined {
        case light
        case dark

        /// Initializing from a button style requires us to invert the styles returned.
        init(_ style: BBButton.Predefined) {
            switch style {
            case .light: self = .dark
            case .dark: self = .light
            case .lightText: self = .light
            }
        }

        var style: (AppTheme) -> (BBLoadingIndicator) -> Void {
            switch self {
            case .light: return BBLoadingIndicator.Style.light
            case .dark: return BBLoadingIndicator.Style.dark
            }
        }
    }
}

// MARK: - Size extensions

extension BBLoadingIndicator {
    public enum Size {
        case small
        case large

        init(_ size: BBButton.Size) {
            switch size {
            case .small: self = .small
            case .large: self = .large
            case .text: self = .small
            }
        }

        var style: (AppTheme) -> (BBLoadingIndicator) -> Void {
            switch self {
            case .small: return BBLoadingIndicator.Style.small
            case .large: return BBLoadingIndicator.Style.large
            }
        }
    }
}

// MARK: - Convenience initializers

extension BBLoadingIndicator {
    public convenience init(theme: AppTheme = BaseTheme, style: BBLoadingIndicator.Predefined, size: BBLoadingIndicator.Size) {
        let indicatorStyle = style.style(theme) <> size.style(theme)
        self.init(style: indicatorStyle)
    }
}
