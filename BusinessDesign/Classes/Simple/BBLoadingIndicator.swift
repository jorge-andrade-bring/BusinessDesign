//
//  Created by Backbase R&D B.V. on 19/02/2019.
//

import UIKit

public class BBLoadingIndicator: MaterialActivityIndicatorView, ThemeInitialized {

    public required convenience init(theme: AppTheme) {
        self.init(style: theme.lightLoadingIndicatorStyle(theme))
    }

    public init(style: (BBLoadingIndicator) -> Void) {
        super.init(frame: .zero)
        style(self)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Question, do we really need something like this?
    static func system(style: UIActivityIndicatorView.Style) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
}

// MARK: - Styles

extension BBLoadingIndicator {
    open class Style {
        open class func light(theme: AppTheme) -> (BBLoadingIndicator) -> Void {
            return { indicator in
                indicator.color = OldDesignSystem.colors.white
            }
        }

        open class func dark(theme: AppTheme) -> (BBLoadingIndicator) -> Void {
            return { indicator in
                indicator.color = OldDesignSystem.colors.primary
            }
        }

        open class func small(theme: AppTheme) -> (BBLoadingIndicator) -> Void {
            return { indicator in
                indicator |> sizeStyle(width: 12, height: 12)
            }
        }

        open class func large(theme: AppTheme) -> (BBLoadingIndicator) -> Void {
            return { indicator in
                indicator |> sizeStyle(width: 24, height: 24)
            }
        }
    }
}
