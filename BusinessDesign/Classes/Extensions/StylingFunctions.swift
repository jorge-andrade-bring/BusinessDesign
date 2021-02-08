//
//  Created by Backbase R&D B.V. on 31/01/2019.
//

import UIKit

// MARK: - UIView

public func autolayoutStyle<V: UIView>(_ view: V) {
    view.translatesAutoresizingMaskIntoConstraints = false
}

public func cornerRadiusStyle<V: UIView>(radius: CGFloat) -> (V) -> Void {
    return { view in
        view.layer.cornerRadius = radius
    }
}

public func backgroundColorStyle<V: UIView>(color: UIColor) -> (V) -> Void {
    return { view in
        view.backgroundColor = color
    }
}

public func sizeStyle<V: UIView>(width: CGFloat? = nil, height: CGFloat? = nil) -> (V) -> Void {
    return { view in
        if let width = width {
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

public func minimumSizeStyle<V: UIView>(width: CGFloat? = nil, height: CGFloat? = nil) -> (V) -> Void {
    return { view in
        if let width = width {
            view.widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
        }

        if let height = height {
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
        }
    }
}

// MARK: - UIButton

public func titleColorStyle<B: UIButton>(color: UIColor, state: UIControl.State = .normal) -> (B) -> Void {
    return { button in
        button.setTitleColor(color, for: state)
    }
}

public func fontStyle<B: UIButton>(font: UIFont) -> (B) -> Void {
    return { button in
        button.titleLabel?.font = font
    }
}

public func contentInsetStyle<B: UIButton>(insets: UIEdgeInsets) -> (B) -> Void {
    return { button in
        button.contentEdgeInsets = insets
    }
}

public func backgroundColorWithImageStyle<B: UIButton>(color: UIColor, forState state: UIControl.State) -> (B) -> Void {
    return { button in
        button.setBackgroundImage(color.singlePixelImage, for: state)
    }
}

public func clippingCornerRadiusStyle<B: UIButton>(radius: CGFloat) -> (B) -> Void {
    return { button in
        button.layer.cornerRadius = radius
        button.layer.masksToBounds = true
    }
}

// MARK: - UILabel

public func textAlignmentStyle<L: UILabel>(alignment: NSTextAlignment) -> (L) -> Void {
    return { label in
        label.textAlignment = alignment
    }
}

public func fontStyle<L: UILabel>(font: UIFont) -> (L) -> Void {
    return { label in
        label.font = font
    }
}

public func textColorStyle<L: UILabel>(color: UIColor) -> (L) -> Void {
    return { label in
        label.textColor = color
    }
}

// MARK: - BBTextField

public func placeholderStyle<T: BBTextField>(font: UIFont, color: UIColor) -> (T) -> Void {
    return { textfield in
        textfield.placeholderAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
        ]
    }
}

public func fontStyle<T: BBTextField>(font: UIFont) -> (T) -> Void {
    return { textfield in
        textfield.font = font
    }
}

public func textColorStyle<T: BBTextField>(color: UIColor) -> (T) -> Void {
    return { textfield in
        textfield.textColor = color
    }
}

public func keyboardStyle<T: BBTextField>(keyboardType: UIKeyboardType) -> (T) -> Void {
    return { textfield in
        textfield.keyboardType = keyboardType
    }
}

public func paddingStyle<T: BBTextField>(padding: UIEdgeInsets) -> (T) -> Void {
    return { textfield in
        textfield.padding = padding
    }
}
