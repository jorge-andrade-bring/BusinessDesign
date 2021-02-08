//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

// MARK: - ListItemTitleConfiguration

/// The configuration DTO that is used to configure the list item title
public class ListItemTitleConfiguration: TextConfigurable {

    /// Defines the font style of the label. Defaults to `DesignSystem.fonts.defaultMedium`.
    public var fontStyle: FontStyle = .defaultMedium

    /// Defines the text color of the label. Defaults to `DesignSystem.colors.black`.
    public var textColorStyle: ColorStyle = .black

    /// Defines the text color of the label. Defaults to `natural`.
    public var alignment: NSTextAlignment = .natural

    /// Defines the text transform of the label. Defaults to `none`.
    public var textTransform: TextTransform = .none

    public enum TextTransform {
        case none
        case sentenceCase
        case upperCase
        case lowerCase
    }
}

// MARK: - BBListItemTitleLabel

/// Atom Label to show title field in a list item
public class BBListItemTitleLabel: BaseLabel {
    override var configuration: TextConfigurable {
        return OldDesignSystem.shared.configuration.list.itemTitle
    }

    override public var text: String? {
        get {
            return super.text
        }
        set {
            guard let textTransform =  (configuration as? ListItemTitleConfiguration)?.textTransform else {
                super.text = newValue
                return
            }
            switch textTransform {
            case .upperCase:
                super.text = newValue?.uppercased()
            case .lowerCase:
                super.text  = newValue?.lowercased()
            case .sentenceCase:
                guard let string = newValue, !string.isEmpty else { return }
                super.text = string.replacingCharacters(in: string.startIndex...string.startIndex,
                                                        with: String(string[string.startIndex]).capitalized)
            case .none: super.text = newValue
            }
        }

    }

}
