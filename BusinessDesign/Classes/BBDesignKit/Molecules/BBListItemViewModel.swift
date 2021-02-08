//
//  Created by Backbase R&D B.V. on 16/01/2020.
//

import UIKit

public struct BBListItemViewModel {
    public var title: String?
    public var subtitle: String?
    public var amount: String?
    public var icon: UIImage?

    public init(title: String?, subtitle: String?, amount: String? = nil, icon: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.amount = amount
        self.icon = icon
    }
}
