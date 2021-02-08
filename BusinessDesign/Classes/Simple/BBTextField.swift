//
//  Created by Backbase R&D B.V. on 22/01/2019.
//

import UIKit

open class BBTextField: UITextField, ThemeInitialized {
    open override var placeholder: String? {
        didSet {
            guard let placeholder = placeholder else { return }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        }
    }

    open var placeholderAttributes: [NSAttributedString.Key: Any] = [:]

    open var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    /// Initializes a new BBTextField with the provided theme.
    /// Will use the `baseTextFieldStyle` AppTheme parameter as the style
    public required convenience init(theme: AppTheme) {
        self.init(style: theme.defaultTextFieldStyle(theme))
    }

    public init(style: (BBTextField) -> Void) {
        super.init(frame: .zero)
        style(self)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: -

    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
}

// MARK: - Styles

extension BBTextField {
    open class Style {
        open class func `default`(theme: AppTheme) -> (BBTextField) -> Void {
            return { field in
                let font = OldDesignSystem.fonts.defaultBold
                field
                    |> autolayoutStyle
                    <> placeholderStyle(font: font, color: OldDesignSystem.colors.black.withAlphaComponent(0.5))
                    <> fontStyle(font: font)
                    <> textColorStyle(color: OldDesignSystem.colors.black)
                    <> keyboardStyle(keyboardType: .default)
                    <> paddingStyle(padding: UIEdgeInsets(top: 0,
                                                          left: theme.grid.baseline(2),
                                                          bottom: 0,
                                                          right: theme.grid.baseline(2)))
            }
        }

        open class func amount(theme: AppTheme) -> (BBTextField) -> Void {
            return { field in
                let font = OldDesignSystem.fonts.h1
                field
                    |> autolayoutStyle
                    <> placeholderStyle(font: font, color: OldDesignSystem.colors.black.withAlphaComponent(0.5))
                    <> fontStyle(font: font)
                    <> textColorStyle(color: OldDesignSystem.colors.black)
                    <> keyboardStyle(keyboardType: .decimalPad)
                    <> paddingStyle(padding: UIEdgeInsets(top: 0,
                                                          left: theme.grid.baseline(2),
                                                          bottom: 0,
                                                          right: theme.grid.baseline(2)))
            }
        }

        open class func formField(theme: AppTheme) -> (BBTextField) -> Void {
            return { field in
                let font = OldDesignSystem.fonts.defaultBold
                field.translatesAutoresizingMaskIntoConstraints = false
                field.font = font
                field.clearButtonMode = .whileEditing
                field.placeholderAttributes = [
                    NSAttributedString.Key.font: font,
                    NSAttributedString.Key.foregroundColor: OldDesignSystem.colors.black.withAlphaComponent(0.5)
                ]
                field.textColor = OldDesignSystem.colors.black
                field.backgroundColor = OldDesignSystem.colors.white
                field.layer.cornerRadius = theme.grid.fine(2)
                field.padding = UIEdgeInsets(top: 0,
                                             left: theme.grid.baseline(2),
                                             bottom: 0,
                                             right: theme.grid.baseline(2))
            }
        }
    }
}
