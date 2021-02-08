//
//  Created by Backbase R&D B.V. on 21/11/2019.
//

import Foundation
import UIKit

public protocol NavigationThemeable where Self: UIViewController {
    func setTitleView(title: String, textColor: UIColor)
}

public extension NavigationThemeable {
    func setTitleView(title: String, textColor: UIColor) {
        let titleLabel = titleView(textColor: textColor)
        titleLabel.text = title
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }

    func setTitleLabel(_ label: UILabel) {
        label.sizeToFit()
        navigationItem.titleView = label
    }
}

public extension NavigationThemeable {
    func titleView(textColor: UIColor) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        if let font = navigationController?.navigationBar.titleTextAttributes?[NSAttributedString.Key.font]
            as? UIFont {
            titleLabel.font = font
        } else {
            titleLabel.font = OldDesignSystem.fonts.h3
        }
        titleLabel.textColor = textColor
        return titleLabel
    }
}
