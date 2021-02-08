//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

// MARK: - ListItemCaptionConfiguration

import UIKit

/// The configuration DTO that is used to configure the list item caption
public class ListItemCaptionConfiguration: TextConfigurable {

    /// Defines the font style of the label. Defaults to `DesignSystem.fonts.subheader`.
    public var fontStyle: FontStyle = .subheader

    /// Defines the text color of the label. Defaults to `DesignSystem.colors.greyest`.
    public var textColorStyle: ColorStyle = .greyest

    /// Defines the text color of the label. Defaults to `natural`.
    public var alignment: NSTextAlignment = .natural
}

// MARK: - BBListItemCaptionLabel

/// Atom Label to show caption field in a list item
public class BBListItemCaptionLabel: BaseLabel {
    override var configuration: TextConfigurable {
        return OldDesignSystem.shared.configuration.list.itemCaption
    }
}
