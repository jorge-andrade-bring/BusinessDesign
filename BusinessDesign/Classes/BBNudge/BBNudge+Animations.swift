//
//  Created by Backbase R&D B.V. on 11/10/2019.
//

// MARK: - Animations
import UIKit

extension BBNudge {

    func animateEntrance() {
        topConstraint?.constant = safeAreaInsets.top > 0 ? safeAreaInsets.top : 24

        animate(animations: { self.superview?.layoutIfNeeded() },
                completion: { _ in self.timer?.fire() })
    }

    func animateDismissal() {
        topConstraint?.constant = -frame.size.height * 2
        centerYConstraint?.isActive = false
        topConstraint?.isActive = true

        animate(animations: {
            self.scaleUp(container: self.superview)
            self.superview?.layoutIfNeeded()
        }, completion: { _ in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        })
    }

    private func animate(animations: @escaping () -> Void, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.4,
                       options: [], animations: animations, completion: completion)
    }

    func animateTransitionIfNeeded(to nextState: NudgeState, duration: TimeInterval) {
        guard runningAnimators.isEmpty else { return }

        let onStateChanged: (NudgeState) -> Void = { state in
            switch state {
            case .collapsed:
                self.centerYConstraint?.isActive = false
                self.topConstraint?.isActive = true
                self.contentViewHeightConstraint?.constant = 0
                self.contentView.alpha = 0
                self.dropDownButton.transform = CGAffineTransform.init(rotationAngle: 0)
                self.scaleUp(container: self.superview)

            case .expanded:
                self.centerYConstraint?.isActive = true
                self.topConstraint?.isActive = false
                self.contentViewHeightConstraint?.constant = self.expandedContentViewHeight
                self.contentView.alpha = 1
                self.dropDownButton.transform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
                self.scaleDown(container: self.superview)
            }
        }

        let transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: nextState.damping) {
            onStateChanged(nextState)
            if self.state == .collapsed {
                self.stopTimer()
            }
            self.superview?.layoutIfNeeded()
        }

        transitionAnimator.addCompletion { position in
            switch position {
            case .start: self.state = nextState.opposite
            case .end: self.state = nextState
            case .current: break
            @unknown default:
                break
            }

            onStateChanged(self.state)
            if self.state == .collapsed {
                self.startTimer()
            }
            self.runningAnimators.removeAll()
        }

        transitionAnimator.startAnimation()

        runningAnimators.append(transitionAnimator)
    }

    // MARK: - Pan gesture recognizer method

    // swiftlint:disable cyclomatic_complexity
    @objc func didMoveView(_ recognizer: UIPanGestureRecognizer) {

        if !hasContentView {
            return
        }

        switch recognizer.state {
        case .began:
            self.animateTransitionIfNeeded(to: self.state.opposite, duration: self.animationDuration)
            self.runningAnimators.forEach { $0.pauseAnimation() }
            self.animationProgress = self.runningAnimators.map { $0.fractionComplete }
        case .changed:
            let translation = recognizer.translation(in: self)
            var fraction = translation.y / expandedContentViewHeight
            fraction = self.state == .expanded ? fraction * -1 : fraction
            fraction = self.runningAnimators[0].isReversed ? fraction * -1 : fraction
            zip(self.runningAnimators, self.animationProgress).forEach { (animator, progress) in
                animator.fractionComplete = progress + fraction
            }
        case .ended:
            let velocity = recognizer.velocity(in: self)
            let shouldExpand = velocity.y > 0

            if velocity.y == 0 {
                runningAnimators.forEach { $0.continueAnimation(withTimingParameters: nil,
                                                                durationFactor: CGFloat(self.animationDuration)) }
                break
            }

            switch self.state {
            case .collapsed:
                if !shouldExpand && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if shouldExpand && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            case .expanded:
                if shouldExpand && !runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
                if !shouldExpand && runningAnimators[0].isReversed { runningAnimators.forEach { $0.isReversed = !$0.isReversed } }
            }

            let velocityVector = CGVector(dx: 0, dy: velocity.y / 100)
            let springParameters = UISpringTimingParameters(dampingRatio: state.opposite.damping, initialVelocity: velocityVector)
            runningAnimators.forEach { $0.continueAnimation(withTimingParameters: springParameters, durationFactor: 0.4) }
        default: break
        }
    }

    func scaleDown(container: UIView?) {
        container?.transform = CGAffineTransform.init(scaleX: 0.91, y: 0.91)
        container?.layer.cornerRadius = 8
        container?.layer.masksToBounds = true
        overlayView.alpha = 0.5
    }

    func scaleUp(container: UIView?) {
        container?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        container?.layer.cornerRadius = 0
        container?.layer.masksToBounds = false
        overlayView.alpha = 0
    }
}
