//
//  Created by Backbase R&D B.V. on 21/01/2020.
//
import UIKit

// MARK: - ListItemAmountConfiguration

/// The configuration DTO that is used to configure the list item amount
public class ListItemAmountConfiguration: TextConfigurable {
    /// Defines the font style of the label. Defaults to `DesignSystem.fonts.defaultMedium`.
    public var fontStyle: FontStyle = .defaultMedium

    /// Defines the text color of the label. Defaults to `DesignSystem.colors.black`.
    public var textColorStyle: ColorStyle = .black

    /// Defines the text color of the label. Defaults to `right`.
    public var alignment: NSTextAlignment = .right
}

// MARK: - BBListItemAmountLabel

/// Atom Label to show amount field in a list item
public class BBListItemAmountLabel: BaseLabel {
    override var configuration: TextConfigurable {
        return OldDesignSystem.shared.configuration.list.itemAmount
    }
}
