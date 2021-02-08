//
//  Created by Backbase R&D B.V. on 05/03/2019.
//

import UIKit

// MARK: - Label types

extension BBLabel {
    public enum Predefined {
        case title
        case subtitle
        case regular

        var style: (AppTheme) -> (BBLabel) -> Void {
            switch self {
            case .title: return { $0.style(for: \.titleLabel) }
            case .subtitle: return { $0.style(for: \.subtitleLabel) }
            case .regular: return { $0.style(for: \.defaultLabel) }
            }
        }
    }
}

// MARK: - Color extensions

// Not sure about the naming of the color enum
extension BBLabel {
    public enum Color {
        case light
        case dark

        var style: (AppTheme) -> (BBLabel) -> Void {
            switch self {
            case .light: return { $0.style(for: \.lightLabel) }
            case .dark: return { $0.style(for: \.darkLabel) }
            }
        }
    }
}

// MARK: - Convenience initializers

extension BBLabel {
    public convenience init(theme: AppTheme = BaseTheme,
                            style: BBLabel.Predefined,
                            color: BBLabel.Color) {
        let labelStyle =
            theme
            |> style.style
            <> color.style

        self.init(style: labelStyle)
    }

    public convenience init(theme: AppTheme = BaseTheme,
                            style: BBLabel.Predefined,
                            color: BBLabel.Color,
                            configuration: (BBLabel) -> Void) {
        self.init(theme: theme, style: style, color: color)
        configuration(self)
    }
}
