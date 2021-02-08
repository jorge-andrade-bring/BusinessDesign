//
//  Created by Backbase R&D B.V. on 22/01/2019.
//

import UIKit

open class BBBaseNavigationController: UINavigationController {
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    public override var shouldAutorotate: Bool {
        return false
    }
}

final public class BBDarkNavigationController: BBBaseNavigationController, ThemeInitialized {
    public required convenience init(theme: AppTheme) {
        self.init(style: theme.darkNavigationController(theme))
    }

    public init(style: (UINavigationBar) -> Void) {
        super.init(nibName: nil, bundle: nil)
        style(self.navigationBar)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

final public class BBLightNavigationController: BBBaseNavigationController, ThemeInitialized {
    public required convenience init(theme: AppTheme) {
        self.init(style: theme.lightNavigationController(theme))
    }

    public init(style: (UINavigationBar) -> Void) {
        super.init(nibName: nil, bundle: nil)
        style(self.navigationBar)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

open class BBNavigationBar: UINavigationBar {
    open class Style {
        open class func dark(theme: AppTheme) -> (UINavigationBar) -> Void {
            return { navigationBar in
                navigationBar.tintColor = OldDesignSystem.colors.white
                navigationBar.barTintColor = OldDesignSystem.colors.secondary
                navigationBar.backgroundColor = OldDesignSystem.colors.secondary
                navigationBar.isTranslucent = false
                navigationBar.shadowImage = UIImage()

                let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BBDarkNavigationController.self])
                let attributes = [
                    NSAttributedString.Key.font: OldDesignSystem.fonts.h3,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.white
                ]
                let largeTitleAttributes = [
                    NSAttributedString.Key.font: OldDesignSystem.fonts.h2,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.white
                ]

                appearance.titleTextAttributes = attributes
                appearance.largeTitleTextAttributes = largeTitleAttributes

                appearance.backIndicatorImage = OldDesignSystem.icons.material(.arrowBack)
                appearance.backIndicatorTransitionMaskImage = OldDesignSystem.icons.material(.arrowBack)
            }
        }

        open class func light(theme: AppTheme) -> (UINavigationBar) -> Void {
            return { navigationBar in
                navigationBar.tintColor = OldDesignSystem.colors.black
                navigationBar.barTintColor = OldDesignSystem.colors.white
                navigationBar.backgroundColor = OldDesignSystem.colors.white
                navigationBar.isTranslucent = false
                navigationBar.shadowImage = UIImage()

                let appearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BBLightNavigationController.self])
                let attributes = [
                    NSAttributedString.Key.font: OldDesignSystem.fonts.h3,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.black
                ]
                let largeTitleAttributes = [
                    NSAttributedString.Key.font: OldDesignSystem.fonts.h2,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.black
                ]

                appearance.titleTextAttributes = attributes
                appearance.largeTitleTextAttributes = largeTitleAttributes

                appearance.backIndicatorImage = OldDesignSystem.icons.material(.arrowBack)
                appearance.backIndicatorTransitionMaskImage = OldDesignSystem.icons.material(.arrowBack)
            }
        }
    }
}
