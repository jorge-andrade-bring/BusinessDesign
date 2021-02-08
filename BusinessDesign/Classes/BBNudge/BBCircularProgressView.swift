//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import BackbaseDesignSystem

public class BBCircularProgressView: UIView {

    public init(lineWidth: CGFloat = 1.5) {
        self.lineWidth = lineWidth
        super.init(frame: .zero)
        isUserInteractionEnabled = false
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public func count(to value: Double) {
        guard let foregroundLayer = layer.sublayers?.last as? CAShapeLayer else { return }

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = value

        foregroundLayer.strokeEnd = 1
        foregroundLayer.add(animation, forKey: "foregroundAnimation")
    }

    override public func layoutSublayers(of layer: CALayer) {
        guard !layoutDone else { return }

        layer.sublayers = [
            circleLayer(strokeEnd: 0, strokeColor: DesignSystem.shared.colors.surfacePrimary.default),
            circleLayer(strokeEnd: 5, strokeColor: DesignSystem.shared.colors.text.support)
        ]

        layoutDone = true
    }

    // MARK: - Private

    private func circleLayer(strokeEnd: CGFloat, strokeColor: UIColor) -> CAShapeLayer {
        let startAngle = (-CGFloat.pi / 2)
        let endAngle = 2 * CGFloat.pi + startAngle

        let path = UIBezierPath(arcCenter: pathCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let layer = CAShapeLayer()

        layer.lineCap = .round
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = strokeColor.cgColor
        layer.strokeEnd = strokeEnd

        return layer
    }

    private var radius: CGFloat {
        let value = frame.width < frame.height ? frame.width : frame.height
        return (value - lineWidth) / 2
    }

    private var pathCenter: CGPoint { return convert(center, from: superview) }
    private var layoutDone = false

    private let lineWidth: CGFloat
}
