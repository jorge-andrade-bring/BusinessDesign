//
//  Created by Backbase R&D B.V. on 12.10.2020.
//

import Foundation
import BackbaseDesignSystem
import UIKit

public extension DesignSystem {
    /// Retail styles.
    var businessStyles: BusinessStyles {
        get {
            guard let styles = objc_getAssociatedObject(self, &AssociatedKeys.businessStyles) as? BusinessStyles else {
                let styles = BusinessStyles()
                objc_setAssociatedObject(self, &AssociatedKeys.businessStyles, styles, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return styles
            }
            return styles
        }

        set {
            objc_setAssociatedObject(self, &AssociatedKeys.businessStyles, newValue as BusinessStyles?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Business styles.
    struct BusinessStyles {

        // MARK: - Common Views Styling

        /// Style applied to all background views
        public var background: Style<UIView> = { view in
            view.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        }

        /// Style applied on UINavigationBars
        public var navigationBar: Style<UINavigationBar> = { navbar in
            navbar.barTintColor = DesignSystem.shared.colors.secondary.default
            navbar.tintColor = DesignSystem.shared.colors.secondary.onDefault

            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = DesignSystem.shared.colors.secondary.default
                appearance.titleTextAttributes = [
                    .foregroundColor: DesignSystem.shared.colors.secondary.onDefault,
                    .font: DesignSystem.shared.fonts.defaultFont(.body, .semibold)
                ]
                appearance.largeTitleTextAttributes = [.foregroundColor: DesignSystem.shared.colors.secondary.onDefault]
                navbar.standardAppearance = appearance
                navbar.compactAppearance = appearance
                navbar.scrollEdgeAppearance = appearance
            } else {
                let textAttributes = [NSAttributedString.Key.foregroundColor: DesignSystem.shared.colors.secondary.onDefault,
                                      NSAttributedString.Key.font: DesignSystem.shared.fonts.defaultFont(.body, .semibold)]
                let largeTextAttributes = [NSAttributedString.Key.foregroundColor: DesignSystem.shared.colors.secondary.onDefault]
                navbar.titleTextAttributes = textAttributes
                navbar.largeTitleTextAttributes = largeTextAttributes
            }
        }
        /// Style applied on UISegmentedControls
        public var segmentedControl: Style<UISegmentedControl> = { ctrl in
            ctrl.tintColor = DesignSystem.shared.colors.surfaceDisabled.default

            ctrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:
                                            DesignSystem.shared.colors.surfaceDisabled.onSurfaceDisabled.default],
                                        for: .selected)
            ctrl.setTitleTextAttributes([.font: DesignSystem.shared.fonts.defaultFont(.subheadline, .semibold)], for: .normal)

        }
        /// Style applied on UINavigationItems
        public var navigationItem: Style<UINavigationItem> = { navItem in
            navItem.titleView?.tintColor = DesignSystem.shared.colors.secondary.onDefault
        }

        /// Style applied on UITabBar. This style applies globally, and manages also the styling of the UITabBarItem appearance.
        public var tabBar: Style<UITabBar> = { tabBar in
            tabBar.tintColor = DesignSystem.shared.colors.primary.default
            tabBar.barTintColor = DesignSystem.shared.colors.surfacePrimary.default
            tabBar.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
            tabBar.unselectedItemTintColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support
            tabBar.isTranslucent = true

            DesignSystem.shared.styles.shadow(.medium)(tabBar.layer)
            tabBar.layer.shadowOffset = CGSize.zero

            var font = DesignSystem.shared.fonts.defaultFont(.caption2, .medium)
            font = UIFont.init(descriptor: font.fontDescriptor, size: 10)

            let normalAttrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                              NSAttributedString.Key.foregroundColor:
                                                                DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support]
            let selectedAttrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                                NSAttributedString.Key.foregroundColor:
                                                                    DesignSystem.shared.colors.primary.default]

            if #available(iOS 13, *) {
                let appearance = tabBar.standardAppearance
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttrs
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttrs
                appearance.configureWithOpaqueBackground()
                appearance.shadowImage = nil
                appearance.shadowColor = nil
                appearance.backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
                tabBar.standardAppearance = appearance
            } else {
                tabBar.shadowImage = UIImage()
                tabBar.backgroundImage = UIImage()
                UITabBarItem.appearance().setTitleTextAttributes(normalAttrs, for: .normal)
                UITabBarItem.appearance().setTitleTextAttributes(selectedAttrs, for: .selected)
            }
        }
        /// Style applied on UITableViews
        public var tableView: Style<UITableView> = { tableView in
            DesignSystem.shared.businessStyles.applySeparatorStyle(style: DesignSystem.shared.businessStyles.separator, on: tableView)
            DesignSystem.shared.businessStyles.background(tableView)
        }
        /// Style applied on UISearchBars
        public var searchBar: Style<UISearchBar> = { searchBar in
            if let searchTextField = searchBar.textField {
                searchBar.barStyle = .default
                // TODO : In Abstract specified to be "colors/2 dark/6 mobile background/1 foundation"
                // but MDS does not provide such color. There for temporarily the following color.
                searchTextField.backgroundColor = DesignSystem.shared.colors.foundation.onFoundation.default
                // TODO : In Abstract specified to be "colors/1 light/5 neutrals/1 white"
                // but MDS does not provide such color. There for temporarily the following color.
                searchTextField.leftView?.tintColor = DesignSystem.shared.colors.primary.onDefault.withAlphaComponent(0.5)
                // TODO : In Abstract specified to be "2 Body/Light/Regular/Left/White"
                // but MDS does not provide such color. There for temporarily the following color.
                searchTextField.font = DesignSystem.shared.fonts.defaultFont(.body, .regular)
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
                    [NSAttributedString.Key.foregroundColor: DesignSystem.shared.colors.primary.onDefault]
            } else {
                // Just a fallback. Should not happen.
                searchBar.barStyle = .black
            }
            searchBar.tintColor = DesignSystem.shared.colors.primary.default
        }

        /// Style applied on separator elements
        public var separator: Style<Separator> = { separator in
            DesignSystem.shared.styles.separator(separator)
        }

        // MARK: - Edge Case View Styling

        /// Style applied to edge case view title labels
        public var edgeCaseTitle: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.title3, .semibold)
            label.textColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.default
            label.numberOfLines = 0
        }

        /// Style applied to all edge case view description label
        public var edgeCaseDescription: Style<UILabel> = { label in
            label.font = DesignSystem.shared.fonts.preferredFont(.callout, .regular)
            label.textColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support
            label.numberOfLines = 0
        }

        /// Style applied to all edge case view icons
        public var edgeCaseImage: Style<UIImageView> = { imageView in
            imageView.tintColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.default
        }

        /// Style applied to all edge case view action buttons
        public var edgeCaseActionButton: Style<Button> = { button in
            DesignSystem.shared.styles.primaryButton(button)
            button.contentEdgeInsets = UIEdgeInsets.init(top: 0,
                                                         left: DesignSystem.shared.spacer.xl,
                                                         bottom: 0,
                                                         right: DesignSystem.shared.spacer.xl)

        }

        // MARK: - helper functions

        /// Applies given separator style to UITableView
        /// - Parameter style: Separator styling function to use
        /// - Parameter tableView: UITableView to apply the separator style on
        ///
        public func applySeparatorStyle(style: Style<Separator>, on tableView: UITableView) {
            let dummySeparator = Separator()
            style(dummySeparator)

            let insets: UIEdgeInsets
            switch dummySeparator.style {
            case .centered:
                insets = UIEdgeInsets.init(top: 0, left: dummySeparator.inset, bottom: 0, right: dummySeparator.inset)
            case .fullWidth:
                insets = UIEdgeInsets.zero
            case .default:
                insets = UIEdgeInsets.init(top: 0, left: dummySeparator.inset, bottom: 0, right: 0)
            @unknown default:
                insets = UIEdgeInsets.init(top: 0, left: dummySeparator.inset, bottom: 0, right: 0)
            }

            tableView.separatorStyle = .singleLine
            tableView.separatorInset = insets
            tableView.separatorColor = dummySeparator.backgroundColor
        }

    }

    // MARK: - Private

    private struct AssociatedKeys {
        static var businessStyles: UInt8 = 0
    }
}

extension UISearchBar {
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        }
        return subviews.first?.subviews.first(where: { $0 as? UITextField != nil }) as? UITextField
    }
}
