//
//  Created by Backbase R&D B.V. on 02/10/2019.
//

import UIKit
import BackbaseDesignSystem

class BBNudgeView: UIView {

    let iconColor: UIColor?
    let icon: UIImage?
    let title: String
    let subtitle: String

    var timer: Timer?

    lazy var closeButton: BBNudgeCloseButton = {
        let button = BBNudgeCloseButton()
        button.backgroundColor = .clear
        button.tintColor = DesignSystem.shared.colors.text.support
        return button
    }()

    lazy var iconImageView: UIImageView = { icon in
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = iconColor ?? .white
        imageView.image = icon?.withRenderingMode(.alwaysTemplate)
        return imageView
    }(icon)

    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = title
        label.accessibilityIdentifier = "nudgeTitle"
        return label
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.text = subtitle
        label.accessibilityIdentifier = "nudgeMessage"
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(type: BBNudgeType, title: String, subtitle: String) {
        self.init(icon: type.icon(), iconColor: type.iconColor(), title: title, subtitle: subtitle)
    }

    init(icon: UIImage?, iconColor: UIColor?, title: String, subtitle: String) {
        self.iconColor = iconColor
        self.icon = icon
        self.title = title
        self.subtitle = subtitle

        super.init(frame: .zero)

        setupView()
        addConstraints()
    }

    func setupView() {
        accessibilityIdentifier = "nudgeView"

        layer.cornerRadius = DesignSystem.shared.cornerRadius.medium

        DesignSystem.shared.styles.shadow(.medium)(self.layer)

        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
        titleLabel.textColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.default
        messageLabel.textColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support
        titleLabel.font = .preferredFont(forTextStyle: .body, weight: .semibold)
        messageLabel.font = .preferredFont(forTextStyle: .subheadline, weight: .regular)

        [closeButton, iconImageView, titleLabel, messageLabel].forEach(addSubview(_:))
    }
}

// MARK: - Constraints

extension BBNudgeView {
    func addConstraints() {
        closeButtonConstraints()
        iconConstraints()
        titleConstraints()
        messageConstraints()
    }

    private func closeButtonConstraints() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.lg).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.lg).isActive = true
        closeButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -DesignSystem.shared.spacer.md).isActive = true
    }

    private func iconConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.lg).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: DesignSystem.shared.sizer.lg).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
    }

    private func titleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -DesignSystem.shared.spacer.sm).isActive = true
    }

    private func messageConstraints() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1.0).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -DesignSystem.shared.spacer.md).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: DesignSystem.shared.spacer.md).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: closeButton.leftAnchor, constant: -DesignSystem.shared.spacer.sm).isActive = true
    }
}
