//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

protocol LabelConfigurable {
    var configuration: TextConfigurable { get }
}

public class BaseLabel: UILabel, LabelConfigurable {
    var configuration: TextConfigurable {
        fatalError("A configuration need to be set for the inherited Label.")
    }

    public override var textAlignment: NSTextAlignment {
        get { return super.textAlignment }
        set { super.textAlignment = newValue }
    }

    public override var textColor: UIColor! {
        get { return super.textColor }
        set { super.textColor = newValue }
    }

    public override var font: UIFont! {
        get { return super.font }
        set { super.font = newValue }
    }

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        applyConfig()
    }

    internal required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        applyConfig()
    }

    func applyConfig() {
        font = configuration.fontStyle.font
        textColor = configuration.textColorStyle.color
        textAlignment = configuration.alignment
        layoutSubviews()
    }
}
