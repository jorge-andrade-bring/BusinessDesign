//
//  Created by Backbase R&D B.V. on 31/01/2019.
//

import UIKit

@available(*, deprecated, message: """
BBTabBarController is deprecated. Applications using UITabBarController
should style the appearance using Mobile Design System.
""")
final public class BBTabBarController: UITabBarController, ThemeInitialized {
    public required convenience init(theme: AppTheme) {
        self.init(style: theme.defaultTabBarController(theme))
    }

    public init(style: (UITabBar) -> Void) {
        super.init(nibName: nil, bundle: nil)

        style(self.tabBar)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
