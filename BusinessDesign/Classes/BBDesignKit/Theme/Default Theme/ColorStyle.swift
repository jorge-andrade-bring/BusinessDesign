//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

public enum ColorStyle {
    // MARK: - Primary
    case primary
    case primaryLightest
    case primaryLighter
    case primaryDarker
    case primaryDarkest

    // MARK: - Secondary

    case secondary
    case secondaryLightest
    case secondaryLighter
    case secondaryDarker
    case secondaryDarkest

    // MARK: - Accent

    case accent
    case accentLightest
    case accentLighter
    case accentDarker
    case accentDarkest

    // MARK: - Support

    case supportDanger
    case supportDangerLightest
    case supportDangerLighter
    case supportDangerDarker
    case supportDangerDarkest
    case supportInfo
    case supportInfoLightest
    case supportInfoLighter
    case supportInfoDarker
    case supportInfoDarkest
    case supportSuccess
    case supportSuccessLightest
    case supportSuccessLighter
    case supportSuccessDarker
    case supportSuccessDarkest
    case supportWarning
    case supportWarningLightest
    case supportWarningLighter
    case supportWarningDarker
    case supportWarningDarkest

    // MARK: - Neutrals

    case transparent
    case white
    case whiteLightest
    case whiteLighter
    case whiteLight
    case grey
    case greyer
    case greyest
    case dark
    case darker
    case black

    // MARK: - Charts

    case charts1
    case charts2
    case charts3
    case charts4
    case charts5
    case charts6
    case charts7
    case charts8
    case charts9
    case charts10
    case mainContentBackgroundColor
}

public extension ColorStyle {

    /// Convenience getter that maps the `ColorStyle` with the `ColorsConfiguration` and returns the respective color value
    var color: UIColor {
        let allColors = OldDesignSystem.colors

        switch self {
        case .primary: return allColors.primary
        case .primaryLightest: return allColors.primaryLightest
        case .primaryLighter: return allColors.primaryLighter
        case .primaryDarker: return allColors.primaryDarker
        case .primaryDarkest: return allColors.primaryDarkest
        case .secondary: return allColors.secondary
        case .secondaryLightest: return allColors.secondaryLightest
        case .secondaryLighter: return allColors.secondaryLighter
        case .secondaryDarker: return allColors.secondaryDarker
        case .secondaryDarkest: return allColors.secondaryDarkest
        case .accent: return allColors.accent
        case .accentLightest: return allColors.accentLightest
        case .accentLighter: return allColors.accentLighter
        case .accentDarker: return allColors.accentDarker
        case .accentDarkest: return allColors.accentDarkest
        case .supportDanger: return allColors.supportDanger
        case .supportDangerLightest: return allColors.supportDangerLightest
        case .supportDangerLighter: return allColors.supportDangerLighter
        case .supportDangerDarker: return allColors.supportDangerDarker
        case .supportDangerDarkest: return allColors.supportDangerDarkest
        case .supportInfo: return allColors.supportInfo
        case .supportInfoLightest: return allColors.supportInfoLightest
        case .supportInfoLighter: return allColors.supportInfoLighter
        case .supportInfoDarker: return allColors.supportInfoDarker
        case .supportInfoDarkest: return allColors.supportInfoDarkest
        case .supportSuccess: return allColors.supportSuccess
        case .supportSuccessLightest: return allColors.supportSuccessLightest
        case .supportSuccessLighter: return allColors.supportSuccessLighter
        case .supportSuccessDarker: return allColors.supportSuccessDarker
        case .supportSuccessDarkest: return allColors.supportSuccessDarkest
        case .supportWarning: return allColors.supportWarning
        case .supportWarningLightest: return allColors.supportWarningLightest
        case .supportWarningLighter: return allColors.supportWarningLighter
        case .supportWarningDarker: return allColors.supportWarningDarker
        case .supportWarningDarkest: return allColors.supportWarningDarkest
        case .transparent: return allColors.transparent
        case .white: return allColors.white
        case .whiteLightest: return allColors.whiteLightest
        case .whiteLighter: return allColors.whiteLighter
        case .whiteLight: return allColors.whiteLight
        case .grey: return allColors.grey
        case .greyer: return allColors.greyer
        case .greyest: return allColors.greyest
        case .dark: return allColors.dark
        case .darker: return allColors.darker
        case .black: return allColors.black
        case .charts1: return allColors.charts1
        case .charts2: return allColors.charts2
        case .charts3: return allColors.charts3
        case .charts4: return allColors.charts4
        case .charts5: return allColors.charts5
        case .charts6: return allColors.charts6
        case .charts7: return allColors.charts7
        case .charts8: return allColors.charts8
        case .charts9: return allColors.charts9
        case .charts10: return allColors.charts10
        case .mainContentBackgroundColor: return allColors.mainContentBackgroundColor
        }
    }
}
