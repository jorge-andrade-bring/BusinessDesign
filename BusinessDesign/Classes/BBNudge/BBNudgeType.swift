//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import BackbaseDesignSystem

public enum BBNudgeType: String {
    case error
    case info
    case warning
    case success

    func icon() -> UIImage {
        switch self {
        case .error:
            return UIImage.named("ic_error_outline", in: .design) ?? UIImage()
        case .info:
            return UIImage.named("ic_info", in: .design) ?? UIImage()
        case .success:
            return UIImage.named("ic_check_circle_outline", in: .design) ?? UIImage()
        case .warning:
            return UIImage.named("ic_warning_amber", in: .design) ?? UIImage()
        }
    }

    func iconColor() -> UIColor {
        switch self {
        case .error:
            return DesignSystem.shared.colors.danger.default
        case .info:
            return DesignSystem.shared.colors.info.default
        case .success:
            return DesignSystem.shared.colors.success.default
        case .warning:
            return DesignSystem.shared.colors.warning.default
        }
    }
}
