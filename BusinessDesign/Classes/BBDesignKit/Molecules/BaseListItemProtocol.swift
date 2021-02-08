//
//  Created by Backbase R&D B.V. on 20/01/2020.
//

import UIKit

public protocol BaseListItemProtocol: UITableViewCell {
    func configure(_ viewModel: BBListItemViewModel)
}
