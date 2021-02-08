//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit
import BackbaseDesignSystem

public class BBNudge: UIView {

    public enum NudgeState {
        case collapsed
        case expanded

        var opposite: NudgeState {
            switch self {
            case .collapsed: return .expanded
            case .expanded: return .collapsed
            }
        }

        var damping: CGFloat { return 0.7 }
    }

    let tapHandler: ((BBNudge) -> Void)?
    let dismissHandler: (() -> Void)?

    let nudgeView: BBNudgeView
    let overlayView: UIView = UIView(frame: .zero)
    let contentView: UIView = UIView(frame: .zero)
    let animationDuration: Double = 0.6
    let nudgeDuration: Double

    private(set) var timer: Timer?

    var topConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    var contentViewHeightConstraint: NSLayoutConstraint?

    var runningAnimators: [UIViewPropertyAnimator] = []
    var animationProgress: [CGFloat] = []

    var expandedContentViewHeight: CGFloat = 0
    var hasContentView: Bool {
        return !contentView.subviews.isEmpty
    }

    var state: NudgeState = .collapsed

    lazy var dropDownButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage.named("ic_arrow_drop_down", in: .design), for: .normal)
        button.tintColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support
        button.isHidden = true
        return button
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func show(message: BBNudgeMessage, in containerView: UIView) -> BBNudge {
        let nudge = BBNudge(message: message)
        nudge.show(in: containerView)
        return nudge
    }

    convenience init(message: BBNudgeMessage) {
        self.init(icon: message.icon,
                  iconColor: message.iconColor,
                  title: message.title,
                  subtitle: message.subtitle,
                  nudgeDuration: message.nudgeDuration,
                  tapHandler: message.onTap,
                  dismissHandler: message.onDismiss,
                  getContentView: message.getContentView)
    }

    init(icon: UIImage?,
         iconColor: UIColor?,
         title: String,
         subtitle: String,
         nudgeDuration: Double = 2.0,
         tapHandler: ((BBNudge) -> Void)? = nil,
         dismissHandler: (() -> Void)? = nil,
         getContentView: ((BBNudge) -> UIView)? = nil) {

        self.nudgeDuration = nudgeDuration
        self.tapHandler = tapHandler
        self.dismissHandler = dismissHandler
        self.nudgeView = BBNudgeView(icon: icon, iconColor: iconColor, title: title, subtitle: subtitle)

        super.init(frame: .zero)

        setupView()
        addConstraints()

        if let contentView = getContentView?(self) {
            dropDownButton.isHidden = false
            setupContentView(view: contentView)
        }
    }

    func setupView() {
        accessibilityIdentifier = "nudge"

        DesignSystem.shared.styles.shadow(.medium)(layer)
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        self.layer.cornerRadius = DesignSystem.shared.cornerRadius.medium
        overlayView.backgroundColor = .black
        overlayView.alpha = 0

        [nudgeView, dropDownButton, contentView].forEach(addSubview(_:))

        setupGestureRecognizers()
    }

    func setupGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onNudgeViewPressed))
        nudgeView.addGestureRecognizer(tapGestureRecognizer)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didMoveView(_:)))
        addGestureRecognizer(panGestureRecognizer)

        nudgeView.closeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        dropDownButton.addTarget(self, action: #selector(toggleContentView), for: .touchUpInside)
    }

    func setupContentView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)

        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        dropDownButton.isHidden = false
        expandedContentViewHeight = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }

    func startTimer() {
        nudgeView.closeButton.setProgress(to: nudgeDuration)
        var animationTime: TimeInterval = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
            animationTime += 0.1
            if animationTime >= (self?.nudgeDuration ?? 2.0) {
                timer.invalidate()
                self?.dismiss()
            }
        })
    }

    func stopTimer() {
        timer?.invalidate()
        nudgeView.closeButton.setProgress(to: 0)
    }

    @objc func onNudgeViewPressed() {
        hasContentView ? toggleContentView() : tapHandler?(self)
    }

    @objc func toggleContentView() {
        animateTransitionIfNeeded(to: self.state.opposite, duration: self.animationDuration)
    }
}

// MARK: - Show

extension BBNudge {

    func show(in superView: UIView) {
        [overlayView, self].forEach(superView.addSubview(_:))

        overlayViewConstraints()
        alertConstraints()

        superView.setNeedsLayout()
        superView.layoutIfNeeded()

        startTimer()
        animateEntrance()
    }

    @objc public func dismiss() {
        dismissHandler?()
        animateDismissal()
    }
}
