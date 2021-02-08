//
//  Created by Backbase R&D B.V. on 28/01/2019.
//

import UIKit

/// This is the global Backbase theme object. Assign your own theme as the new value if you want to override how the
/// default components get their looks.
@available(*, deprecated, message: "Use DesignSystem instead for the latest configurations")
public var BaseTheme: AppTheme = BBTheme()

public protocol ThemeInitialized: class {
    init(theme: AppTheme)
}

@available(*, deprecated, message: "BBTheme is deprecated, use DesignSystem instead for the latest configurations")
open class BBTheme: AppTheme {
    @available(*, deprecated, message: "BaseTheme.colors is deprecated, use DesignSystem.colors instead")
    open var colors: ColorsConfiguration
    @available(*, deprecated, message: "BaseTheme.fonts is deprecated, use DesignSystem.fonts instead")
    open var fonts: FontsConfiguration
    @available(*, deprecated, message: "BaseTheme.icons is deprecated, use DesignSystem.icons instead")
    open var icons: IconsConfiguration
    @available(*, deprecated, message: "BaseTheme.grid is deprecated")
    open var grid: AppGrid

    // MARK: - TextField styles

    open var defaultTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { return BBTextField.Style.default }
    open var amountTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { return BBTextField.Style.amount }
    open var formFieldTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { return BBTextField.Style.formField }

    // MARK: - Button styles

    open var baseButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.base }
    open var smallButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.small }
    open var largeButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.large }
    open var lightButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.light }
    open var darkButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.dark }
    open var textButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.text }
    open var lightTextButton: (AppTheme) -> (BBButton) -> Void { return BBButton.Style.lightText }

    // MARK: - Label styles

    open var defaultLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.default }
    open var lightLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.light }
    open var titleLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.title }
    open var darkLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.dark }
    open var subtitleLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.subtitle }
    open var amountLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.amount }
    open var formFieldLabel: (AppTheme) -> (UILabel) -> Void { return BBLabel.Style.formFieldTitle }

    // MARK: - TabBar controller styles

    open var defaultTabBarController: (AppTheme) -> (UITabBar) -> Void { return BBTabBar.Style.default }

    // MARK: - NavigationController styles

    open var darkNavigationController: (AppTheme) -> (UINavigationBar) -> Void { return BBNavigationBar.Style.dark }
    open var lightNavigationController: (AppTheme) -> (UINavigationBar) -> Void { return BBNavigationBar.Style.light }

    // MARK: - Loading indicator styles

    open var lightLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { return BBLoadingIndicator.Style.light }
    open var darkLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { return BBLoadingIndicator.Style.dark }
    open var largeLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { return BBLoadingIndicator.Style.large }
    open var smallLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { return BBLoadingIndicator.Style.small }

    // MARK: - Keypath based getter function

    open func style<Component>(for keyPath: KeyPath<AppTheme, (AppTheme) -> (Component) -> Void>) -> (Component) -> Void {
        return self[keyPath: keyPath](self)
    }

    // MARK: - Init

    required public init(colors: ColorsConfiguration = OldDesignSystem.colors,
                         fonts: FontsConfiguration = OldDesignSystem.fonts,
                         grid: AppGrid = BBGrid(),
                         icons: IconsConfiguration = OldDesignSystem.icons) {
        self.colors = colors
        self.fonts = fonts
        self.grid = grid
        self.icons = icons
    }
}
