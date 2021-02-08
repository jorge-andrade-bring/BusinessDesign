//
//  Created by Backbase R&D B.V. on 30/01/2019.
//

import UIKit

open class BBLabel: UILabel, ThemeInitialized {
    open var localizedTitle: String? {
        get {
            return localizationKey
        }
        set {
            self.localizationKey = newValue
        }
    }

    private var localizationKey: String? {
        didSet {
            //            self.text = localizationKey?.bb.localized
        }
    }

    public required convenience init(theme: AppTheme) {
        self.init(style: theme.defaultLabel(theme))
    }

    public init(style: (BBLabel) -> Void) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        style(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Styles

extension BBLabel {
    open class Style {
        open class func `default`(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.font = OldDesignSystem.fonts.default
                label.numberOfLines = 0
                label.lineBreakMode = .byWordWrapping
            }
        }

        open class func formFieldTitle(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label
                    |> autolayoutStyle
                    <> textColorStyle(color: OldDesignSystem.colors.greyest)
                    <> textAlignmentStyle(alignment: .left)
                    <> {
                        $0.font = OldDesignSystem.fonts.subheader
                    }
            }
        }

        open class func title(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.font = OldDesignSystem.fonts.h2
                label.textAlignment = .center
            }
        }

        open class func light(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.textColor = OldDesignSystem.colors.white
            }
        }

        open class func dark(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.textColor = OldDesignSystem.colors.black
            }
        }

        open class func subtitle(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.font = OldDesignSystem.fonts.subtitle
                label.textColor = OldDesignSystem.colors.black.withAlphaComponent(0.5)
                label.textAlignment = .left
            }
        }

        open class func amount(theme: AppTheme) -> (UILabel) -> Void {
            return { label in
                label.font = OldDesignSystem.fonts.defaultBold
                label.textColor = OldDesignSystem.colors.black
                label.textAlignment = .right
            }
        }
    }
}
