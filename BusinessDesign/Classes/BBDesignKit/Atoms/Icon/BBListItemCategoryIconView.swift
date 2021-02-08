//
//  Created by Backbase R&D B.V. on 15/01/2020.
//

// MARK: - ListItemCategoryItem

/// The configuration DTO that is used to configure the list item category icon
public class ListItemCategoryIconConfiguration: IconConfiguration {

    /// Defines the icon corner radius behavior. Defaults to `square`.
    public var backgroundShape: IconBackgroundShape = .square

    /// Defines the background color of the view (this property's behavior may get affected from the `tintBehavior`).
    /// Defaults to `DesignSystem.colors.white`.
    public var backgroundColor: ColorStyle = .white

    /// Defines the foreground color of the view (the image tint color) (this property's behavior may get affected from the `tintBehavior`).
    /// Defaults to `DesignSystem.colors.primary`.
    public var foregroundColor: ColorStyle = .primary

    /// Defines how the Icon Atom applies the colors to itself. Defaults to `none`.
    public var applyTintColorTo: IconTintBehavior = .none
}

// MARK: - BBListItemCategoryIconView

/// Atom view to show category icon in a list item
final public class BBListItemCategoryIconView: BaseIconView {

    override var configuration: IconConfiguration {
        return OldDesignSystem.shared.configuration.list.itemCategoryIcon
    }
}
