//
//  Created by Backbase R&D B.V. on 12/06/2019.
//

import UIKit

public class SubtitleTableViewCell: UITableViewCell {
    public struct ViewModel {
        public var title: String
        public var subtitle: String
        public var caption: String?

        public init(title: String, subtitle: String, caption: String? = nil) {
            self.title = title
            self.subtitle = subtitle
            self.caption = caption
        }
    }

    @IBOutlet weak var titleLabel: BBLabel!
    @IBOutlet weak var subtitleLabel: BBLabel!
    @IBOutlet weak var captionLabel: BBLabel!

    override public func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none

        accessibilityIdentifier = "subtitleTableViewCell"

        titleLabel.font = OldDesignSystem.fonts.subtitle
        titleLabel.textColor = OldDesignSystem.colors.dark
        titleLabel.accessibilityIdentifier = "subtitleTableViewCell.cellTitle"

        subtitleLabel.font = OldDesignSystem.fonts.defaultMedium
        subtitleLabel.textColor = OldDesignSystem.colors.black
        subtitleLabel.accessibilityIdentifier = "subtitleTableViewCell.cellSubtitle"

        captionLabel.font = OldDesignSystem.fonts.default
        captionLabel.textColor = OldDesignSystem.colors.black
        captionLabel.accessibilityIdentifier = "subtitleTableViewCell.cellCaption"
    }

    public func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        if let caption = viewModel.caption {
            captionLabel.text = caption
            captionLabel.isHidden = false
            subtitleLabel.textColor = OldDesignSystem.colors.black
        } else {
            captionLabel.isHidden = true
        }
    }
}
