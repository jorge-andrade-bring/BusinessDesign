//
//  Created by Backbase R&D B.V. on 4/6/20.
//

import Foundation
import UIKit

public class BBBadgeView: UIView {

    public enum Style {
        case small
        case large
    }

    public var max: Int = 99
    public var count: Int = 0 {
        didSet {
            refreshViews()
        }
    }
    public var style: Style = .large {
        didSet {
            setUpViews()
        }
    }

    private let label = UILabel()
    private var leadingConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    private var widthConstraint: NSLayoutConstraint?

    private var hasMaxBeenReached: Bool { count > max }
    private var badgeSize: CGFloat {
        switch style {
        case .small: return 8
        case .large: return 18
        }
    }
    private var leadingConstraintConstant: CGFloat {
        switch style {
        case .small:
            return -4
        case .large:
            return hasMaxBeenReached ? -12 : -8
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    // MARK: - Private

    private func setUpViews() {
        label.removeFromSuperview()

        // Check if Height & Width constaints needs to be added or disabled
        if heightConstraint == nil {
            heightConstraint = heightAnchor.constraint(equalToConstant: badgeSize)
        } else { heightConstraint?.isActive = false }

        if widthConstraint == nil {
            widthConstraint = widthAnchor.constraint(equalToConstant: badgeSize)
        } else { widthConstraint?.isActive = false }

        switch style {
        case .large: setUpLargeBadgeViews()
        case .small: setUpSmallBadgeViews()
        }

        isUserInteractionEnabled = false
        backgroundColor = OldDesignSystem.colors.supportDanger
        layer.cornerRadius = badgeSize / 2

        refreshViews()
    }

    private func setUpLargeBadgeViews() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false

        heightConstraint?.constant = badgeSize
        heightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        label.textColor = OldDesignSystem.colors.white
        label.font = OldDesignSystem.fonts.subheaderBold
    }

    private func setUpSmallBadgeViews() {
        [widthConstraint, heightConstraint].forEach {
            $0?.constant = badgeSize
            $0?.isActive = true
        }
    }

    public func pinToSuperviewTopRight() {
        guard let superview = superview, leadingConstraint == nil else { return }

        let leadingConstraint = leadingAnchor.constraint(equalTo: superview.trailingAnchor, constant: leadingConstraintConstant)
        self.leadingConstraint = leadingConstraint

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: -4),
            leadingConstraint
        ])
    }

    private func refreshViews() {
        let isHidden = count <= 0
        label.text = hasMaxBeenReached ? "\(max)+" : "\(count)"
        leadingConstraint?.constant = leadingConstraintConstant
        self.isHidden = isHidden
    }
}
