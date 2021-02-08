//
//  Created by Backbase R&D B.V. on 28/01/2019.
//

import UIKit

public protocol AppGrid {
    var baseline: (CGFloat) -> CGFloat { get }
    var fine: (CGFloat) -> CGFloat { get }
}
