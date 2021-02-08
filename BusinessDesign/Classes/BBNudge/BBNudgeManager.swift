//
//  Created by Backbase R&D B.V. on 22/05/2019.
//

import UIKit

open class BBNudgeManager {

    public static let shared = BBNudgeManager()

    public var isNudgeVisible: Bool { nudgesQueue.count > 0 }

    private weak var window: UIWindow?
    private lazy var nudgesQueue: [BBNudgeMessage] = [BBNudgeMessage]()

    convenience init() {
        self.init(window: UIApplication.shared.keyWindow)
    }

    public init(window: UIWindow?) {
        self.window = window
    }

    public func queueNudge(title: String,
                           subtitle: String,
                           nudgeDuration: Double = 2,
                           type: BBNudgeType = .info,
                           tapHandler: ((BBNudge) -> Void)? = nil,
                           getContentView: ((BBNudge) -> UIView)? = nil) {
        queueNudge(title: title,
                   subtitle: subtitle,
                   nudgeDuration: nudgeDuration,
                   icon: type.icon(),
                   iconColor: type.iconColor(),
                   tapHandler: tapHandler,
                   getContentView: getContentView)
    }

    public func queueNudge(title: String,
                           subtitle: String,
                           nudgeDuration: Double = 2,
                           icon: UIImage?,
                           iconColor: UIColor?,
                           tapHandler: ((BBNudge) -> Void)? = nil,
                           getContentView: ((BBNudge) -> UIView)? = nil) {

        let nudgeMessage = BBNudgeMessage(title: title,
                                          subtitle: subtitle,
                                          icon: icon,
                                          iconColor: iconColor,
                                          nudgeDuration: nudgeDuration,
                                          onTap: tapHandler,
                                          onDismiss: onNudgeDismissed,
                                          getContentView: getContentView)

        // Queue the nudge
        nudgesQueue.append(nudgeMessage)

        // If there is only one nudge in the queue, show it
        if nudgesQueue.count == 1 {
            showNudge(nudgeMessage: nudgeMessage)
        }
    }

    func showNudge(nudgeMessage: BBNudgeMessage) {
        guard let window = window else { return }

        BBNudge(message: nudgeMessage).show(in: window)
    }

    func onNudgeDismissed() {
        if nudgesQueue.count > 0 {
            nudgesQueue.removeFirst()
        }

        if let nextNudge = nudgesQueue.first {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showNudge(nudgeMessage: nextNudge)
            }
        }
    }
}
