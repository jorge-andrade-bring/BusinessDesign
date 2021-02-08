//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

public protocol TextConfigurable {
    var fontStyle: FontStyle { get set }
    var textColorStyle: ColorStyle { get set }
    var alignment: NSTextAlignment { get set }
}
