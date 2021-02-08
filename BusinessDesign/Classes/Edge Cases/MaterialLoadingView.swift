//
//  Created by Backbase R&D B.V. on 03/06/2019.
//

import UIKit
import BackbaseDesignSystem

public class MaterialLoadingView: UIView {

    // MARK: - Public

    public var color: UIColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support {
        didSet {
            indicatorView.color = color
            titleLabel.textColor = color
        }
    }

    public var title: String? {
        didSet {
            titleLabel.isHidden = false
            titleLabel.text = title
        }
    }

    // MARK: - Private

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = DesignSystem.shared.fonts.preferredFont(.body, .regular)
        label.textColor = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.support
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(style: .whiteLarge)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    // MARK: - View Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setupViewsLayout() {
        addSubview(titleLabel)
        addSubview(indicatorView)

        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: 44),
            indicatorView.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.topAnchor.constraint(equalTo: indicatorView.bottomAnchor,
                                            constant: DesignSystem.shared.spacer.md),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: DesignSystem.shared.spacer.md),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -DesignSystem.shared.spacer.md)
        ])

        indicatorView.color = color
        indicatorView.startAnimating()
        backgroundColor = DesignSystem.shared.colors.surfacePrimary.default
    }
}
