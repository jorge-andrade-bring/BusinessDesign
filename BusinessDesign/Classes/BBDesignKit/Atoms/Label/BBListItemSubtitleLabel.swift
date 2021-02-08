//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

// MARK: - ListItemSubtitleConfiguration

/// The configuration DTO that is used to configure the list item subtitle
public class ListItemSubtitleConfiguration: TextConfigurable {

    /// Defines the font style of the label. Defaults to `DesignSystem.fonts.subtitle`.
    public var fontStyle: FontStyle = .subtitle

    /// Defines the text color of the label. Defaults to `DesignSystem.colors.greyest`.
    public var textColorStyle: ColorStyle = .dark

    /// Defines the text color of the label. Defaults to `natural`.
    public var alignment: NSTextAlignment = .natural
}

// MARK: - BBListItemSubtitleLabel

/// Atom Label to show subtitle field in a list item
public class BBListItemSubtitleLabel: BaseLabel {
    override var configuration: TextConfigurable {
        return OldDesignSystem.shared.configuration.list.itemSubtitle
    }
}
