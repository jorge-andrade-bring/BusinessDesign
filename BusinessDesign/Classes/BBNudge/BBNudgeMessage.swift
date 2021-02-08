//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

struct BBNudgeMessage {
    let title: String
    let subtitle: String
    let icon: UIImage?
    let iconColor: UIColor?
    let nudgeDuration: Double
    let onTap: ((BBNudge) -> Void)?
    let onDismiss: (() -> Void)?
    let getContentView: ((BBNudge) -> UIView)?
}
