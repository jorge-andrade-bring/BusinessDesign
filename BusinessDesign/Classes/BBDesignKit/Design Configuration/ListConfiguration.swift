//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import Foundation

public class ListConfiguration {

    /// The configuration DTO that is used to configure the list item title
    public private(set) var itemTitle = ListItemTitleConfiguration()

    /// The configuration DTO that is used to configure the list item subtitle
    public private(set) var itemSubtitle = ListItemSubtitleConfiguration()

    /// The configuration DTO that is used to configure the list item caption
    public private(set) var itemCaption = ListItemCaptionConfiguration()

    /// The configuration DTO that is used to configure the list item amount
    public private(set) var itemAmount = ListItemAmountConfiguration()

    /// The configuration DTO that is used to configure the list item category icon
    public private(set) var itemCategoryIcon = ListItemCategoryIconConfiguration()

    /// The configuration DTO that is used to configure the list item trend icon
    public private(set) var itemTrendIcon = ListItemTrendIconConfiguration()

    /// This method will create and return an ListItemTitleConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func title(closure: (ListItemTitleConfiguration) -> Void) {
        closure(itemTitle)
    }

    /// This method will create and return an ListItemSubtitleConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func subtitle(closure: (ListItemSubtitleConfiguration) -> Void) {
        closure(itemSubtitle)
    }

    /// This method will create and return an ListItemCaptionConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func caption(closure: (ListItemCaptionConfiguration) -> Void) {
        closure(itemCaption)
    }

    /// This method will create and return an ListItemAmountConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func amount(closure: (ListItemAmountConfiguration) -> Void) {
        closure(itemAmount)
    }

    /// This method will create and return an ListItemCategoryIconConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func itemCategoryIcon(_ closure: (ListItemCategoryIconConfiguration) -> Void) {
        closure(itemCategoryIcon)
    }

    /// This method will create and return an ListItemTrendIconConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func itemTrendIcon(_ closure: (ListItemTrendIconConfiguration) -> Void) {
        closure(itemTrendIcon)
    }
}
