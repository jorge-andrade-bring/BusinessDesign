//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import UIKit

public class BaseIconView: UIView, BaseIcon {

    /// This property overrides its default behavior and won't effect the view. Please use `setImage(_:, withTintColor:)` instead.
    public override var tintColor: UIColor! {
        get { return super.tintColor }
        // swiftlint:disable unused_setter_value
        set {}
    }

    // MARK: - View Lifecycle

    internal convenience init() {
        self.init(frame: .zero)
    }

    internal required override init(frame: CGRect) {
        super.init(frame: frame)

        setupViewHierarchy()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()

        setupViewHierarchy()
        setupLayout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        setupLayout()
    }

    /// Sets the image and the tintColor of the icon atom.
    /// - Parameters:
    ///   - image: The image to be set on the icon atom
    ///   - imageTintColor: The color of the background view or the imageView depending on the `applyTintColorTo` configuration setting.
    ///   Only applicable if IconTintBehavior setting is `foreground` or `background`.
    public func setImage(_ image: UIImage?, withTintColor imageTintColor: UIColor? = nil) {
        self.image = image
        self.imageTintColor = imageTintColor

        applyTintBehavior()
    }

    // MARK: - Private Properties

    internal var configuration: IconConfiguration {
        fatalError("A configuration need to be set for the inherited Icon Atom.")
    }

    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var imageTintColor: UIColor?
    private var image: UIImage? {
        didSet {
            imageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
    }
}

// MARK: - Private setups

extension BaseIconView {

    private func setupLayout() {
        backgroundColor = OldDesignSystem.colors.transparent

        setupBackgroundShape()
        applyTintBehavior()
    }

    private func setupBackgroundShape() {
        switch configuration.backgroundShape {
        case .circle:
            containerView.layer.cornerRadius = containerView.bounds.height/2
        default:
            containerView.layer.cornerRadius = configuration.backgroundShape.radius
        }
    }

    private func applyTintBehavior() {
        if imageTintColor == nil {
            applyDefaultColorsBehavior()
            return
        }

        switch configuration.applyTintColorTo {
        case .none:
            applyDefaultColorsBehavior()
        case .foreground:
            containerView.backgroundColor = configuration.backgroundColor.color
            imageView.tintColor = imageTintColor
        case .background:
            containerView.backgroundColor = imageTintColor
            imageView.tintColor = configuration.foregroundColor.color
        }
    }

    private func applyDefaultColorsBehavior() {
        containerView.backgroundColor = configuration.backgroundColor.color
        imageView.tintColor = configuration.foregroundColor.color
    }

    private func setupViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate(
            [
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                containerView.topAnchor.constraint(equalTo: topAnchor),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
                imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -6),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -6)
            ]
        )
    }
}
