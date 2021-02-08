//
//  Created by Backbase R&D B.V. on 03/06/2019.
//
import UIKit
import BackbaseDesignSystem

public protocol EdgeCaseLoadable {
    var edgeCaseView: EdgeCaseView { get set }
    var edgeCaseTitle: String? { get }
    var edgeCaseDescription: String? { get }
    var edgeCaseImage: UIImage? { get }
    var edgeCaseImageTintColor: UIColor? { get }
    var edgeCaseTopInset: CGFloat { get }

    var actionButtonTitle: String? { get }
    func actionButtonHandler()
}

public extension EdgeCaseLoadable {
    var actionButtonTitle: String? { return nil }

    func actionButtonHandler() {}
}

public class EdgeCaseView: UIView {

    private let loader: EdgeCaseLoadable

    public init(loader: EdgeCaseLoadable) {
        self.loader = loader
        super.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300))

        setupViewsLayout()
        setupViewsHierarchy()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    /// Bind UI to the given data or the default values coming from EdgeCaseLoadable protocol getters
    ///
    /// - Parameters:
    ///   - title: the title of the EdgeCaseView. If empty, the default `edgeCaseTitle` from EdgeCaseLoadable protocol will be used
    ///   - description: the description of the EdgeCaseView. If empty, the default
    ///   `edgeCaseDescription` from EdgeCaseLoadable protocol will be used
    ///   - image: the image of the EdgeCaseView. If empty, the default `edgeCaseImage` from EdgeCaseLoadable protocol will be used
    ///   - showActionButton: show or hide action button if needed
    public func update(title: String? = nil, description: String? = nil, image: UIImage? = nil, showActionButton: Bool = true) {
        titleLabel.text = title ?? loader.edgeCaseTitle
        titleLabel.accessibilityIdentifier = "edgeCaseView.title"
        descriptionLabel.text = description ?? loader.edgeCaseDescription
        descriptionLabel.accessibilityIdentifier = "edgeCaseView.description"
        imageView.image = image ?? loader.edgeCaseImage
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        if let tintColor = loader.edgeCaseImageTintColor {
            imageView.tintColor = tintColor
        }
        imageView.accessibilityIdentifier = "edgeCaseView.image"

        centerYConstraint.constant = (loader.edgeCaseTopInset / 2)

        if showActionButton {
            addActionButton()
        } else {
            removeActionButton()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Setups

    private func setupViewsLayout() {
        DesignSystem.shared.businessStyles.background(self)
        clipsToBounds = true
        DesignSystem.shared.businessStyles.edgeCaseTitle(titleLabel)
        DesignSystem.shared.businessStyles.edgeCaseDescription(descriptionLabel)
        DesignSystem.shared.businessStyles.edgeCaseActionButton(actionButton)
        DesignSystem.shared.businessStyles.edgeCaseImage(imageView)
    }

    private func setupViewsHierarchy() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(imageView)

        centerYConstraint = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        BottomConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYConstraint,
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 48),
            imageView.widthAnchor.constraint(equalToConstant: 48),
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: DesignSystem.shared.spacer.xl),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -DesignSystem.shared.spacer.xl),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: DesignSystem.shared.spacer.sm),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: DesignSystem.shared.spacer.xs),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                      constant: DesignSystem.shared.spacer.xl),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                       constant: -DesignSystem.shared.spacer.xl),
            BottomConstraint
        ])

        addActionButton()
    }

    private func addActionButton() {
        if containerView.subviews.contains(actionButton) {
            actionButton.removeFromSuperview()
        }

        if let buttonTitle = loader.actionButtonTitle {
            containerView.addSubview(actionButton)
            actionButton.setTitle(buttonTitle, for: .normal)
            actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)

            BottomConstraint.isActive = false

            NSLayoutConstraint.activate([
                actionButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: DesignSystem.shared.spacer.sm),
                actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -DesignSystem.shared.spacer.md)
            ])
        }

        actionButton.layoutIfNeeded()
        descriptionLabel.layoutIfNeeded()
        containerView.layoutIfNeeded()
    }

    private func removeActionButton() {
        actionButton.removeFromSuperview()
        BottomConstraint.isActive = true
        descriptionLabel.layoutIfNeeded()
        containerView.layoutSubviews()
    }

    @objc private func actionButtonTapped() {
        loader.actionButtonHandler()
    }

    private let titleLabel = BBLabel(style: .title, color: .dark) *> {
        $0.numberOfLines = 0
    }

    private let descriptionLabel = BBLabel(style: .subtitle, color: .dark) *> {
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let imageView = UIImageView(frame: .zero) *> {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let containerView = UIView(frame: .zero) *> {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
    }

    private lazy var actionButton: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var centerYConstraint = NSLayoutConstraint()
    private var BottomConstraint = NSLayoutConstraint()
}
