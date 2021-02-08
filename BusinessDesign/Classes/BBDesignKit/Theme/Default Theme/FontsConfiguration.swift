//
//  Created by Backbase R&D B.V. on 30/01/2019.
//

import UIKit

final public class FontsConfiguration {

    /// Default size is 28 pt and weight is bold
    public var h1 = FontsConfiguration.font(ofSize: 28, weight: .bold)

    /// Default size is 22 pt and weight is bold
    public var h2 = FontsConfiguration.font(ofSize: 22, weight: .bold)

    /// Default size is 18 pt and weight is bold
    public var h3 = FontsConfiguration.font(ofSize: 18, weight: .bold)

    /// Default size is 16 pt and weight is regular
    public var `default` = FontsConfiguration.font(ofSize: 16)

    /// Default size is 16 pt and weight is medium
    public var defaultMedium = FontsConfiguration.font(ofSize: 16, weight: .medium)

    /// Default size is 16 pt and weight is bold
    public var defaultBold = FontsConfiguration.font(ofSize: 16, weight: .bold)

    /// Default size is 14 pt and weight is regular
    public var subtitle = FontsConfiguration.font(ofSize: 14)

    /// Default size is 14 pt and weight is bold
    public var subtitleBold = FontsConfiguration.font(ofSize: 14, weight: .bold)

    /// Default size is 14 pt and weight is semibold
    public var subtitleSemiBold = FontsConfiguration.font(ofSize: 14, weight: .semibold)

    /// Default size is 12 pt and weight is regular
    public var subheader = FontsConfiguration.font(ofSize: 12)

    /// Default size is 12 pt and weight is bold
    public var subheaderBold = FontsConfiguration.font(ofSize: 12, weight: .bold)

    /// Default size is 12 pt and weight is semi bold
    public var subheaderSemiBold = FontsConfiguration.font(ofSize: 12, weight: .semibold)

    /// Default size is 10 pt and weight is regular
    public var caption = FontsConfiguration.font(ofSize: 10, weight: .regular)

    /// Default size is 10 pt and weight is medium
    public var captionMedium = FontsConfiguration.font(ofSize: 10, weight: .medium)

    /// Default size is 10 pt and weight is medium
    public var tabbarItemTitle = FontsConfiguration.font(ofSize: 10, weight: .medium)

    public init() {}

    /// This method will create and return an FontsConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public static func configure(_ closure: (FontsConfiguration) -> Void) -> FontsConfiguration {
        let config = FontsConfiguration()
        closure(config)
        return config
    }
}

private extension FontsConfiguration {

    /// Returns a preferred `UIFont` based on the given `UIFont.TextStyle` parameter.
    /// - returns:
    ///     A UIFont object.
    /// - parameters:
    ///     - textStyle: A `UIFont.TextStyle` enum to use as the text style of the preferred font.
    private static func font(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
