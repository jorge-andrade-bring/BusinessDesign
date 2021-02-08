//
//  Created by Backbase R&D B.V. on 21/01/2019.
//

import UIKit

open class BBButton: UIButton, ThemeInitialized {
    private var title: String?

    public enum ButtonState {
        case enabled
        case disabled
        case loading
    }

    private(set) var intendedSize: CGSize = .zero

    open var viewState: ButtonState = .enabled {
        didSet {
            switch viewState {
            case .loading:
                self.isEnabled = false

                self.title = self.title(for: .normal)
                self.setTitle(nil, for: .normal)

                self.addSubview(self.activityIndicator, constraints: [
                    equal(\.centerXAnchor),
                    equal(\.centerYAnchor)
                ])
                self.activityIndicator.startAnimating()
            case .enabled:
                self.isEnabled = true

                if self.activityIndicator.superview == nil { return }

                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()

                self.setTitle(self.title, for: .normal)
            case .disabled:
                self.isEnabled = false

                if self.activityIndicator.superview == nil { return }

                self.activityIndicator.stopAnimating()
                self.activityIndicator.removeFromSuperview()

                self.setTitle(self.title, for: .normal)
            }
        }
    }

    public let activityIndicator: BBLoadingIndicator

    // MARK: - Init methods

    public required convenience init(theme: AppTheme) {
        let buttonStyle =
            theme
            |> theme.baseButton
            <> theme.largeButton
            <> theme.lightButton

        self.init(style: buttonStyle,
                  loadingIndicatorStyle: theme.lightLoadingIndicatorStyle(theme))
    }

    public init(style: (BBButton) -> Void, loadingIndicatorStyle: (BBLoadingIndicator) -> Void) {
        self.activityIndicator = BBLoadingIndicator(style: loadingIndicatorStyle)
        super.init(frame: .zero)
        style(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Styles

extension BBButton {
    open class Style {
        open class func base(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = OldDesignSystem.fonts.default
                button.tintColor = OldDesignSystem.colors.primary
                button.adjustsImageWhenDisabled = true
                button.adjustsImageWhenHighlighted = true
            }
        }

        open class func small(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                // Maybe some kind of configuration?
                button.intendedSize = CGSize(width: 80, height: 32)

                button
                    |> clippingCornerRadiusStyle(radius: button.intendedSize.height / 2)
                    <> minimumSizeStyle(width: button.intendedSize.width)
                    <> contentInsetStyle(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
                    <> fontStyle(font: OldDesignSystem.fonts.subtitle)
                    <> sizeStyle(height: button.intendedSize.height)
            }
        }

        open class func large(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button.intendedSize = CGSize(width: 152, height: 48)

                button
                    |> clippingCornerRadiusStyle(radius: button.intendedSize.height / 2)
                    <> minimumSizeStyle(width: button.intendedSize.width)
                    <> contentInsetStyle(insets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))
                    <> fontStyle(font: OldDesignSystem.fonts.default)
                    <> sizeStyle(height: button.intendedSize.height)
            }
        }

        open class func light(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button
                    |> backgroundColorWithImageStyle(color: OldDesignSystem.colors.white, forState: .normal)
                    <> titleColorStyle(color: OldDesignSystem.colors.primary)
            }
        }

        open class func dark(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button
                    |> backgroundColorWithImageStyle(color: OldDesignSystem.colors.primary, forState: .normal)
                    <> titleColorStyle(color: OldDesignSystem.colors.white)
            }
        }

        open class func text(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button.backgroundColor = OldDesignSystem.colors.transparent
                button.titleLabel?.font = OldDesignSystem.fonts.subtitle
            }
        }

        open class func lightText(theme: AppTheme) -> (BBButton) -> Void {
            return { button in
                button
                    |> backgroundColorWithImageStyle(color: OldDesignSystem.colors.transparent, forState: .normal)
                    <> titleColorStyle(color: OldDesignSystem.colors.white)
            }
        }
    }
}
