//
//  Created by Backbase R&D B.V. on 11/10/2019.
//

// MARK: - Constraints

extension BBNudge {

    func addConstraints() {
        nudgeViewConstraints()
        dropDownConstraints()
        contentViewConstraints()
    }

    func overlayViewConstraints() {
        guard let superview = superview else { return }

        overlayView.translatesAutoresizingMaskIntoConstraints = false

        overlayView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        overlayView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        overlayView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 0).isActive = true
        overlayView.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 0).isActive = true
    }

    func alertConstraints() {
        guard let superview = superview else { return }

        translatesAutoresizingMaskIntoConstraints = false

        topConstraint = topAnchor.constraint(equalTo: superview.topAnchor, constant: -frame.height * 0.2)
        centerYConstraint = centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 0)
        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: BaseTheme.grid.baseline(1)).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: BaseTheme.grid.baseline(-1)).isActive = true

        topConstraint?.isActive = true
    }

    private func nudgeViewConstraints() {
        nudgeView.translatesAutoresizingMaskIntoConstraints = false

        nudgeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        nudgeView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        nudgeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }

    private func dropDownConstraints() {
        dropDownButton.translatesAutoresizingMaskIntoConstraints = false
        dropDownButton.topAnchor.constraint(equalTo: nudgeView.bottomAnchor, constant: BaseTheme.grid.baseline(-3)).isActive = true
        dropDownButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func contentViewConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true

        contentView.topAnchor.constraint(equalTo: nudgeView.bottomAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: BaseTheme.grid.baseline(1)).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: BaseTheme.grid.baseline(-1)).isActive = true
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: 0)
        contentViewHeightConstraint?.isActive = true
    }
}
