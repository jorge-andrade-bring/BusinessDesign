//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import BackbaseDesignSystem

open class BBNudgeCloseButton: UIButton {
    private let circleProgress: BBCircularProgressView

    required public init() {
        circleProgress = BBCircularProgressView(lineWidth: 2)

        super.init(frame: .zero)

        let image = UIImage.named("ic_close", in: .design)
        setImage(image, for: .normal)
        addSubview(circleProgress)

        circleProgress.translatesAutoresizingMaskIntoConstraints = false

        circleProgress.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        circleProgress.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        circleProgress.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleProgress.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setProgress(to value: Double) {
        circleProgress.count(to: value)
    }
}
