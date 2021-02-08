//
//  Created by Backbase R&D B.V. on 05/03/2019.
//

import UIKit

@available(*, deprecated, message: """
BBTabBar is deprecated. Applications using a UITabBar should
style the bar appearance using Mobile Design System.
""")
open class BBTabBar: UITabBar {
    open class Style {
        open class func `default`(theme: AppTheme) -> (UITabBar) -> Void {
            return { tabBar in
                tabBar.tintColor = OldDesignSystem.colors.primary
                tabBar.backgroundColor = OldDesignSystem.colors.white
                tabBar.barTintColor = OldDesignSystem.colors.white
                tabBar.isTranslucent = true

                tabBar.layer.shadowColor = UIColor.black.cgColor
                tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
                tabBar.layer.shadowRadius = 4
                tabBar.layer.shadowOpacity = 0.1
                tabBar.layer.masksToBounds = false

                if #available(iOS 13, *) {
                    let appearance = tabBar.standardAppearance
                    appearance.configureWithOpaqueBackground()
                    appearance.shadowImage = nil
                    appearance.shadowColor = nil
                    tabBar.standardAppearance = appearance
                } else {
                    tabBar.shadowImage = UIImage()
                    tabBar.backgroundImage = UIImage()
                }

                UITabBarItem.appearance(whenContainedInInstancesOf: [BBTabBarController.self]).setTitleTextAttributes([
                    NSAttributedString.Key.font: OldDesignSystem.fonts.tabbarItemTitle,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.primary
                ], for: .selected)

                UITabBarItem.appearance(whenContainedInInstancesOf: [BBTabBarController.self]).setTitleTextAttributes([
                                                                                                                        NSAttributedString.Key.font: OldDesignSystem.fonts.tabbarItemTitle,
                                                                                                                        NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.grey], for: .normal)
            }
        }
    }
}
