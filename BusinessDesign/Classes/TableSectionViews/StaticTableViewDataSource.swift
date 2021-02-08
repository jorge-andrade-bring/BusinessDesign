//
//  Created by Backbase R&D B.V. on 04/12/2019.
//

import UIKit

public struct StaticTableViewSection {
    let numberOfRows: Int
    let cellType: UITableViewCell.Type

    public init(numberOfRows: Int, cellType: UITableViewCell.Type) {
        self.numberOfRows = numberOfRows
        self.cellType = cellType
    }
}

public class StaticTableViewDataSource: NSObject, UITableViewDataSource {

    public let sections: [StaticTableViewSection]

    public init(sections: [StaticTableViewSection] = []) {
        self.sections = sections
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = sections[indexPath.section].cellType
        let cellIdentifier = String(describing: cellType)
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell()
    }
}
