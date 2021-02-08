//
//  Created by Backbase R&D B.V. on 30/01/2019.
//

import UIKit

public struct BBGrid: AppGrid {
    public typealias GridFunction = (CGFloat) -> CGFloat

    public var baseline: GridFunction
    public var fine: GridFunction

    public init(baseline: @escaping GridFunction = { return $0 * 8 },
                fine: @escaping GridFunction = { return $0 * 4 }) {
        self.baseline = baseline
        self.fine = fine
    }
}
