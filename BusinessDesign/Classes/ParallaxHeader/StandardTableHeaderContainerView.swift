//
//  Created by Backbase R&D B.V. on 12/10/2020.
//

import UIKit

public class StandardTableHeaderContainerView: UIView {

    public init(header: UIView, frame: CGRect) {
        self.headerView = header
        super.init(frame: frame)

        clipsToBounds = true
        setupHeaderLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private let headerView: UIView
}

// MARK: - Private Setups

private extension StandardTableHeaderContainerView {
    func setupHeaderLayout() {
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                headerView.topAnchor.constraint(equalTo: topAnchor),
                headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                headerView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}
