//
//  Created by Backbase R&D B.V. on 25/02/2020.
//

import UIKit

public class ParallaxContainerView: UIView {

    // MARK: - Public

    public let headerHeight: CGFloat

    public init(header: UIView, height: CGFloat) {
        self.header = header
        self.headerHeight = height
        super.init(frame: .zero)

        clipsToBounds = true
        setupHeaderLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                superview.leadingAnchor.constraint(equalTo: leadingAnchor),
                superview.topAnchor.constraint(equalTo: topAnchor),
                superview.trailingAnchor.constraint(equalTo: trailingAnchor),
                superview.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }

    // MARK: - Private

    private let header: UIView
}

// MARK: - Private Setups

private extension ParallaxContainerView {
    func setupHeaderLayout() {
        addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                header.centerYAnchor.constraint(equalTo: centerYAnchor),
                header.heightAnchor.constraint(equalToConstant: headerHeight),
                header.leadingAnchor.constraint(equalTo: leadingAnchor),
                header.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
}
