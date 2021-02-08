//
//  Created by Backbase R&D B.V. on 30/01/2019.
//

import UIKit

/// The protocol used to define the complete application theme
public protocol AppTheme: class {
    init(colors: ColorsConfiguration, fonts: FontsConfiguration, grid: AppGrid, icons: IconsConfiguration)

    var colors: ColorsConfiguration { get }
    var fonts: FontsConfiguration { get }
    var icons: IconsConfiguration { get }
    var grid: AppGrid { get }

    // MARK: - BBTextField styles
    var defaultTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { get }
    var amountTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { get }
    var formFieldTextFieldStyle: (AppTheme) -> (BBTextField) -> Void { get }

    // MARK: - BBButton styles
    var baseButton: (AppTheme) -> (BBButton) -> Void { get }
    var smallButton: (AppTheme) -> (BBButton) -> Void { get }
    var largeButton: (AppTheme) -> (BBButton) -> Void { get }
    var lightButton: (AppTheme) -> (BBButton) -> Void { get }
    var darkButton: (AppTheme) -> (BBButton) -> Void { get }
    var textButton: (AppTheme) -> (BBButton) -> Void { get }
    var lightTextButton: (AppTheme) -> (BBButton) -> Void { get }

    // MARK: - BBLabel styles
    var defaultLabel: (AppTheme) -> (UILabel) -> Void { get }
    var lightLabel: (AppTheme) -> (UILabel) -> Void { get }
    var titleLabel: (AppTheme) -> (UILabel) -> Void { get }
    var darkLabel: (AppTheme) -> (UILabel) -> Void { get }
    var subtitleLabel: (AppTheme) -> (UILabel) -> Void { get }
    var amountLabel: (AppTheme) -> (UILabel) -> Void { get }
    var formFieldLabel: (AppTheme) -> (UILabel) -> Void { get }

    // MARK: - BBTabBarController styles
    var defaultTabBarController: (AppTheme) -> (UITabBar) -> Void { get }

    // MARK: - BBNavigationController styles
    var darkNavigationController: (AppTheme) -> (UINavigationBar) -> Void { get }
    var lightNavigationController: (AppTheme) -> (UINavigationBar) -> Void { get }

    // MARK: - BBLoadingIndicator styles
    var lightLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { get }
    var darkLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { get }
    var largeLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { get }
    var smallLoadingIndicatorStyle: (AppTheme) -> (BBLoadingIndicator) -> Void { get }

    func style<Component>(for keyPath: KeyPath<AppTheme, (AppTheme) -> (Component) -> Void>) -> (Component) -> Void
}
