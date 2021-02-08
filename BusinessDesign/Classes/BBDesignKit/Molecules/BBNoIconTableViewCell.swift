//
//  Created by Backbase R&D B.V. on 16/01/2020.
//

import UIKit

public class BBNoIconTableViewCell: UITableViewCell, BaseListItemProtocol {

    @IBOutlet weak var titleLabel: BBListItemTitleLabel!
    @IBOutlet weak var subtitleLabel: BBListItemSubtitleLabel!
    @IBOutlet weak var amountLabel: BBListItemAmountLabel!

    public override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setAccessibilityIdentifiers()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = selected ? OldDesignSystem.colors.whiteLight : OldDesignSystem.colors.white
    }

    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = highlighted ? OldDesignSystem.colors.whiteLight : OldDesignSystem.colors.white
    }

    public func configure(_ viewModel: BBListItemViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        amountLabel.text = viewModel.amount
    }

    func setAccessibilityIdentifiers() {
        accessibilityIdentifier = "BBNoIconTableViewCell"
        subtitleLabel.accessibilityIdentifier = "cell.subtitleLabel"
        titleLabel.accessibilityIdentifier = "cell.titleLabel"
        amountLabel.accessibilityIdentifier = "cell.amountLabel"
    }
}
