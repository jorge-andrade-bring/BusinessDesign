//
//  Created by Backbase R&D B.V. on 15/01/2020.
//

// MARK: - ListItemTrendItem

/// The configuration DTO that is used to configure the list item trend icon
public class ListItemTrendIconConfiguration: IconConfiguration {

    /// Defines the icon corner radius behavior. Defaults to `small`.
    public var backgroundShape: IconBackgroundShape = .small

    /// Defines the background color of the view (this property's behavior may get affected from the `tintBehavior`).
    /// Defaults to `DesignSystem.colors.secondary`.
    public var backgroundColor: ColorStyle = .secondary

    /// Defines the foreground color of the view (the image tint color) (this property's behavior may get affected from the `tintBehavior`).
    /// Defaults to `DesignSystem.colors.white`.
    public var foregroundColor: ColorStyle = .white

    /// Defines how the Icon Atom applies the colors to itself. Defaults to `none`.
    public var applyTintColorTo: IconTintBehavior = .none
}

// MARK: - BBListItemTrendIconView

final public class BBListItemTrendIconView: BaseIconView {

    override var configuration: IconConfiguration {
        return OldDesignSystem.shared.configuration.list.itemTrendIcon
    }
}
