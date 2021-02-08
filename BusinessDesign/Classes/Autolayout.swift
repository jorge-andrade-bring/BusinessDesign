//
//  Created by Backbase R&D B.V. on 19/02/2019.
//

import UIKit

public typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

@discardableResult
public func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant)
}

@discardableResult
public func equal<L, Axis>(_ from: KeyPath<UIView, L>,
                           _ to: KeyPath<UIView, L>,
                           constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}

@discardableResult
public func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

extension UIView {
    public func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}
