//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import Foundation

/// The configuration DTO that is used to configure the Design System for the app
public class DesignConfiguration {

    /// The configuration DTO that is used to configure the list design. By list we refer to the UITableView.
    public private(set) var list = ListConfiguration()

    public init() {}

    /// This method will create and return an DesignConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public static func configure(closure: (DesignConfiguration) -> Void) -> DesignConfiguration {
        let config = DesignConfiguration()
        closure(config)
        return config
    }

    /// This method will create and return an ListConfiguration DTO based on the pre-specified objects in the closure
    /// - Parameter closure: The closure that will define the values that the DTO will take
    public func list(_ closure: (ListConfiguration) -> Void) {
        closure(list)
    }
}
