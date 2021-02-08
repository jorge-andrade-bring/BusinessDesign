//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

public enum FontStyle {
    case h1
    case h2
    case h3

    case `default`
    case defaultBold
    case defaultMedium

    case subtitle
    case subtitleBold

    case subheader
    case subheaderBold

    case tabbarItemTitle
}

public extension FontStyle {

    /// Convenience getter that maps the `FontStyle` with the `FontsConfiguration` and returns the respective font value
    var font: UIFont {
        let allFonts = OldDesignSystem.fonts
        switch self {
        case .h1:
            return allFonts.h1
        case .h2:
            return allFonts.h2
        case .h3:
            return allFonts.h3
        case .default:
            return allFonts.default
        case .defaultBold:
            return allFonts.defaultBold
        case .defaultMedium:
            return allFonts.defaultMedium
        case .subtitle:
            return allFonts.subtitle
        case .subtitleBold:
            return allFonts.subtitleBold
        case .subheader:
            return allFonts.subheader
        case .subheaderBold:
            return allFonts.subheaderBold
        case .tabbarItemTitle:
            return allFonts.tabbarItemTitle
        }
    }
}
