//
//  Created by Backbase R&D B.V. on 30/01/2019.
//

import UIKit

public final class ColorsConfiguration {
    public init() {}

    // MARK: - Primary
    public var primary = UIColor(hex6: 0x0079C9)
    public var primaryLightest = UIColor(hex6: 0xE0EFF8)
    public var primaryLighter = UIColor(hex6: 0x5BB0E1)
    public var primaryDarker = UIColor(hex6: 0x00689F)
    public var primaryDarkest = UIColor(hex6: 0x005581)

    // MARK: - Secondary

    public var secondary = UIColor(hex6: 0x181e41)
    public var secondaryLightest = UIColor(hex6: 0xE7E7EB)
    public var secondaryLighter = UIColor(hex6: 0x5E627A)
    public var secondaryDarker = UIColor(hex6: 0x11152D)
    public var secondaryDarkest = UIColor(hex6: 0x0D1024)

    // MARK: - Accent

    public var accent = UIColor(hex6: 0xFF870A)
    public var accentLightest = UIColor(hex6: 0xFFF0E1)
    public var accentLighter = UIColor(hex6: 0xFFB965)
    public var accentDarker = UIColor(hex6: 0xC27202)
    public var accentDarkest = UIColor(hex6: 0xA05D02)

    // MARK: - Support

    public var supportDanger = UIColor(hex6: 0xD32F2F)
    public var supportDangerLightest = UIColor(hex6: 0xFAE6E6)
    public var supportDangerLighter = UIColor(hex6: 0xE88380)
    public var supportDangerDarker = UIColor(hex6: 0xA7312A)
    public var supportDangerDarkest = UIColor(hex6: 0x872621)
    public var supportInfo = UIColor(hex6: 0x1476CC)
    public var supportInfoLightest = UIColor(hex6: 0xE2EEF9)
    public var supportInfoLighter = UIColor(hex6: 0x6BAFE2)
    public var supportInfoDarker = UIColor(hex6: 0x0667A0)
    public var supportInfoDarkest = UIColor(hex6: 0x045383)
    public var supportSuccess = UIColor(hex6: 0x2E7D32)
    public var supportSuccessLightest = UIColor(hex6: 0xE5EFE6)
    public var supportSuccessLighter = UIColor(hex6: 0x7DB082)
    public var supportSuccessDarker = UIColor(hex6: 0x27682D)
    public var supportSuccessDarkest = UIColor(hex6: 0x1E5424)
    public var supportWarning = UIColor(hex6: 0xFBC02D)
    public var supportWarningLightest = UIColor(hex6: 0xFEF7E5)
    public var supportWarningLighter = UIColor(hex6: 0xFDDA7F)
    public var supportWarningDarker = UIColor(hex6: 0xBE9728)
    public var supportWarningDarkest = UIColor(hex6: 0x9B7B1F)

    // MARK: - Neutrals

    public var transparent = UIColor.clear
    public var white = UIColor(hex6: 0xFFFFFF)
    public var whiteLightest = UIColor(hex6: 0xF5F5F5)
    public var whiteLighter = UIColor(hex6: 0xF2F2F2)
    public var whiteLight = UIColor(hex6: 0xE9EAEB)
    public var grey = UIColor(hex6: 0xDEDEDE)
    public var greyer = UIColor(hex6: 0xC5C5C5)
    public var greyest = UIColor(hex6: 0xA2A2A2)
    public var dark = UIColor(hex6: 0x737373)
    public var darker = UIColor(hex6: 0x3C3C3C)
    public var black = UIColor(hex6: 0x000000)

    // MARK: - Charts

    public var charts1 = UIColor(hex6: 0xFA6400)
    public var charts2 = UIColor(hex6: 0xF7B500)
    public var charts3 = UIColor(hex6: 0x6DD400)
    public var charts4 = UIColor(hex6: 0x44D7B6)
    public var charts5 = UIColor(hex6: 0x32C5FF)
    public var charts6 = UIColor(hex6: 0x0091FF)
    public var charts7 = UIColor(hex6: 0x6236FF)
    public var charts8 = UIColor(hex6: 0xB620E0)
    public var charts9 = UIColor(hex6: 0xEB65DD)
    public var charts10 = UIColor(hex6: 0xF5428F)
    public var charts11 = UIColor(hex6: 0x00A1E0)

    public var mainContentBackgroundColor = UIColor(hex6: 0xf5f6f7)

    /// This method will create and return an ColorsConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public static func configure(_ closure: (ColorsConfiguration) -> Void) -> ColorsConfiguration {
        let config = ColorsConfiguration()
        closure(config)
        return config
    }
}
