//
//  Created by Backbase R&D B.V. on 15/01/2020.
//

import Foundation

// MARK: - IconConfiguration
protocol IconConfiguration {

    var backgroundShape: IconBackgroundShape { get set }
    var backgroundColor: ColorStyle { get set }
    var foregroundColor: ColorStyle { get set }
    var applyTintColorTo: IconTintBehavior { get set }
}
