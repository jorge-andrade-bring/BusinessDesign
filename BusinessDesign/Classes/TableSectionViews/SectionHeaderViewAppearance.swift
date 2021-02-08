//
//  Created by Backbase R&D B.V. on 4/10/20.
//

import UIKit

extension SectionHeaderView {
    public struct Appearance {
        let color: UIColor
        let backgroundColor: UIColor?
        let font: UIFont
        let icon: UIImage?

        // We need this initializer to make it available publicly
        public init(color: UIColor, font: UIFont, icon: UIImage? = nil, backgroundColor: UIColor? = nil) {
            self.color = color
            self.font = font
            self.icon = icon
            self.backgroundColor = backgroundColor
        }
    }
}
