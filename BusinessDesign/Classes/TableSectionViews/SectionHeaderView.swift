//
//  Created by Backbase R&D B.V. on 03/06/2019.
//

import UIKit

public class SectionHeaderView: UIView {

    private let appearance: Appearance

    public private(set) var titleLabel = BBLabel(style: .title, color: .dark) *> {
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = OldDesignSystem.fonts.subheaderSemiBold
        $0.textColor = OldDesignSystem.colors.dark
    }

    public init(title: String?, appearance: Appearance) {
        self.appearance = appearance
        super.init(frame: .zero)
        titleLabel.text = title
        setupViewsLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewsLayout() {
        addSubview(titleLabel)

        backgroundColor = appearance.backgroundColor ?? .white
        titleLabel.textColor = appearance.color
        titleLabel.font = appearance.font

        NSLayoutConstraint.activate(
            [
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalPadding)
            ]
        )
    }
}

// MARK: - Private Constants

fileprivate extension SectionHeaderView {

    struct Constants {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 10
    }
}
