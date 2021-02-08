//
//  Created by Backbase R&D B.V. on 19/02/2019.
//

import Foundation

public extension BBTextField {
    enum Predefined {
        case `default`
        case amount
        case form

        var style: (AppTheme) -> (BBTextField) -> Void {
            switch self {
            case .default: return BBTextField.Style.default
            case .amount: return BBTextField.Style.amount
            case .form: return BBTextField.Style.formField
            }
        }
    }
}

// MARK: - Convenience initializers

public extension BBTextField {
    convenience init(theme: AppTheme = BaseTheme, style: BBTextField.Predefined) {
        self.init(style: style.style(theme))
    }
}
