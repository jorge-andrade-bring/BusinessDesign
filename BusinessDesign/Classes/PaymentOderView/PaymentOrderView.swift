//
//  Created by Backbase R&D B.V. on 3/27/20.
//

import UIKit
import BackbaseDesignSystem

/// Protocol for providing style functions for PaymentOrderView from different journeys
public protocol PaymentOrderStyling {

    /// Style applied to all support labels on PaymentOrderView
    var paymentOrderSupportLabel: Style<UILabel> { get }

    /// Style applied to CounterParty name and Amount labels on PaymentOrderView
    var paymentOrderTitleLabel: Style<UILabel> { get }

    /// Style applied to payment order participant names on PaymentOrderView
    var paymentOrderParticipantNameLabel: Style<UILabel> { get }

    /// Style applied to occurrence/execution date value labels on PaymentOrderView
    var paymentOrderOccurrenceValueLabel: Style<UILabel> { get }

    /// Style applied to vertical divider in PaymentOrderView
    var paymentOrderVerticalDivider: Style<UIView> { get }
}

public class PaymentOrderView: UIView {

    internal var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.amountLabel"
        label.textAlignment = .right
        return label
    }()

    internal var counterpartyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.counterpartyTitleLabel"
        return label
    }()

    internal var counterpartyAccountTitleOuterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    internal var counterpartyAccountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.counterpartyAccountTitleLabel"
        return label
    }()

    internal var counterpartyAccountNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.counterpartyAccountNumberLabel"
        return label
    }()

    internal var executionDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.executionDateLabel"
        return label
    }()

    internal var executionDateValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.executionDateValueLabel"
        return label
    }()

    internal var occursLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.occursLabel"
        return label
    }()

    internal var occursValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.occursValueLabel"
        return label
    }()

    internal var originatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.originatorLabel"
        return label
    }()

    internal var originatorAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "approvalTableViewCell.originatorAccountLabel"
        return label
    }()

    internal var counterpartyAccountView: UIView = {
        let stackView = UIView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    internal var originatorAccountView: UIView = {
        let stackView = UIView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    internal var verticalDividerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupViewHierarchy()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public enum DisplayMode {
        case payments
        case multiSelectApprovals
        case approvalsList
    }

    public func configure(_ viewModel: PaymentOderViewModel, mode: DisplayMode) {
        configure(viewModel, mode: mode, stylingConfiguration: nil)
    }

    public func configure(_ viewModel: PaymentOderViewModel, mode: DisplayMode, stylingConfiguration: PaymentOrderStyling? = nil) {
        counterpartyTitleLabel.text = viewModel.counterpartyName
        if mode == .payments {
            counterpartyAccountTitleLabel.isHidden = true
            counterpartyAccountNumberLabel.isHidden = true
            counterpartyAccountTitleOuterLabel.text = viewModel.counterpartyTitle
        } else {
            if mode == .approvalsList {
                originatorLabel.isHidden = true
                originatorAccountLabel.isHidden = true
                originatorAccountView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            }
            counterpartyAccountTitleLabel.text = viewModel.counterpartyTitle
            counterpartyAccountTitleOuterLabel.isHidden = true
        }
        counterpartyAccountNumberLabel.text = viewModel.counterpartyAccountNumber
        executionDateLabel.text = viewModel.executionDate
        executionDateValueLabel.text = viewModel.executionDateValue
        amountLabel.text = viewModel.amount
        originatorLabel.text = viewModel.originatorName
        originatorAccountLabel.text = viewModel.originatorAccount
        occursLabel.text = viewModel.occurs
        occursValueLabel.text = viewModel.occursValue
        [counterpartyAccountTitleOuterLabel, counterpartyAccountNumberLabel,
         originatorAccountLabel, occursLabel, executionDateLabel].forEach { label in
            stylingConfiguration?.paymentOrderSupportLabel(label)
        }
        [amountLabel, counterpartyTitleLabel].forEach { label in
            stylingConfiguration?.paymentOrderTitleLabel(label)
        }
        [occursValueLabel, executionDateValueLabel].forEach { label in
            stylingConfiguration?.paymentOrderOccurrenceValueLabel(label)
        }
        [originatorLabel, counterpartyAccountTitleLabel].forEach { label in
            stylingConfiguration?.paymentOrderParticipantNameLabel(label)
        }
        stylingConfiguration?.paymentOrderVerticalDivider(verticalDividerView)
    }
}

extension PaymentOrderView {
    func setupViews() {
        // Default styling. Journeys can override these styles through passing a PaymentOrderStyling protocol instance in configure calls.
        let colors = DesignSystem.shared.colors
        let fonts = DesignSystem.shared.fonts

        counterpartyTitleLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        counterpartyTitleLabel.font = fonts.preferredFont(.headline, .semibold)

        amountLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        amountLabel.font = fonts.preferredFont(.headline, .semibold)

        counterpartyAccountTitleLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        counterpartyAccountTitleLabel.font = fonts.preferredFont(.body, .regular)

        originatorLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        originatorLabel.font = fonts.preferredFont(.body, .regular)

        occursValueLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        occursValueLabel.font = fonts.preferredFont(.subheadline, .semibold)

        executionDateValueLabel.textColor = colors.surfacePrimary.onSurfacePrimary.default
        executionDateValueLabel.font = fonts.preferredFont(.subheadline, .semibold)

        counterpartyAccountTitleOuterLabel.textColor = colors.surfacePrimary.onSurfacePrimary.support
        counterpartyAccountTitleOuterLabel.font = fonts.preferredFont(.subheadline, .regular)

        counterpartyAccountNumberLabel.textColor = colors.surfacePrimary.onSurfacePrimary.support
        counterpartyAccountNumberLabel.font = fonts.preferredFont(.subheadline, .regular)

        originatorAccountLabel.textColor = colors.surfacePrimary.onSurfacePrimary.support
        originatorAccountLabel.font = fonts.preferredFont(.subheadline, .regular)

        occursLabel.textColor = colors.surfacePrimary.onSurfacePrimary.support
        occursLabel.font = fonts.preferredFont(.subheadline, .regular)

        executionDateLabel.textColor = colors.surfacePrimary.onSurfacePrimary.support
        executionDateLabel.font = fonts.preferredFont(.subheadline, .regular)

        // colors/1 light/5 neutrals/7 greyest TODO : MDS does not provide yet the neutrals colors. See MDS-162
        verticalDividerView.backgroundColor = colors.surfacePrimary.onSurfacePrimary.disabled
        verticalDividerView.layer.cornerRadius = DesignSystem.shared.cornerRadius.small
    }

    private func setupViewHierarchy() {
        [counterpartyTitleLabel, counterpartyAccountTitleOuterLabel, verticalDividerView, counterpartyAccountView,
         originatorAccountView, occursLabel, occursValueLabel, executionDateLabel, executionDateValueLabel,
         amountLabel].forEach { view in self.addSubview(view)}
        setupOriginatorCounterPartViewHiearchy()
        setupOriginatorAccountViewHiearchy()

        let spacer = DesignSystem.shared.spacer

        NSLayoutConstraint.activate([
            counterpartyTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            counterpartyTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            counterpartyTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            counterpartyAccountTitleOuterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            counterpartyAccountTitleOuterLabel.topAnchor.constraint(equalTo: counterpartyTitleLabel.bottomAnchor, constant: spacer.xxs),
            counterpartyAccountTitleOuterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            verticalDividerView.widthAnchor.constraint(equalToConstant: spacer.xs),
            verticalDividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            verticalDividerView.topAnchor.constraint(equalTo: counterpartyAccountTitleOuterLabel.bottomAnchor, constant: spacer.sm),
            verticalDividerView.bottomAnchor.constraint(equalTo: originatorAccountView.bottomAnchor, constant: spacer.sm),
            counterpartyAccountView.leadingAnchor.constraint(equalTo: verticalDividerView.trailingAnchor, constant: spacer.sm),
            counterpartyAccountView.topAnchor.constraint(equalTo: verticalDividerView.topAnchor, constant: spacer.sm),
            counterpartyAccountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),

            originatorAccountView.leadingAnchor.constraint(equalTo: verticalDividerView.trailingAnchor, constant: spacer.sm),
            originatorAccountView.topAnchor.constraint(equalTo: counterpartyAccountView.bottomAnchor, constant: 0),
            originatorAccountView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            occursLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            occursLabel.topAnchor.constraint(equalTo: verticalDividerView.bottomAnchor, constant: spacer.sm),
            occursValueLabel.leadingAnchor.constraint(equalTo: occursLabel.trailingAnchor, constant: spacer.xs),
            occursValueLabel.centerYAnchor.constraint(equalTo: occursLabel.centerYAnchor, constant: 0),
            executionDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            executionDateLabel.topAnchor.constraint(equalTo: occursValueLabel.bottomAnchor, constant: spacer.xs),
            executionDateValueLabel.leadingAnchor.constraint(equalTo: executionDateLabel.trailingAnchor, constant: spacer.xs),
            executionDateValueLabel.centerYAnchor.constraint(equalTo: executionDateLabel.centerYAnchor, constant: 0),
            amountLabel.topAnchor.constraint(equalTo: executionDateValueLabel.bottomAnchor, constant: spacer.md),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            amountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    private func setupOriginatorCounterPartViewHiearchy() {
        counterpartyAccountView.addSubview(counterpartyAccountTitleLabel)
        counterpartyAccountView.addSubview(counterpartyAccountNumberLabel)

        let spacer = DesignSystem.shared.spacer

        NSLayoutConstraint.activate([
            counterpartyAccountTitleLabel.leadingAnchor.constraint(equalTo: counterpartyAccountView.leadingAnchor, constant: 0),
            counterpartyAccountTitleLabel.topAnchor.constraint(equalTo: counterpartyAccountView.topAnchor, constant: 0),
            counterpartyAccountTitleLabel.trailingAnchor.constraint(equalTo: counterpartyAccountView.trailingAnchor, constant: 0),
            counterpartyAccountNumberLabel.leadingAnchor.constraint(equalTo: counterpartyAccountView.leadingAnchor, constant: 0),
            counterpartyAccountNumberLabel.topAnchor.constraint(equalTo: counterpartyAccountTitleLabel.bottomAnchor, constant: spacer.xxs),
            counterpartyAccountNumberLabel.trailingAnchor.constraint(equalTo: counterpartyAccountView.trailingAnchor, constant: 0),
            counterpartyAccountNumberLabel.bottomAnchor.constraint(equalTo: counterpartyAccountView.bottomAnchor, constant: 0)
        ])
    }

    private func setupOriginatorAccountViewHiearchy() {
        originatorAccountView.addSubview(originatorLabel)
        originatorAccountView.addSubview(originatorAccountLabel)

        let spacer = DesignSystem.shared.spacer

        NSLayoutConstraint.activate([
            originatorLabel.leadingAnchor.constraint(equalTo: originatorAccountView.leadingAnchor, constant: 0),
            originatorLabel.topAnchor.constraint(equalTo: originatorAccountView.topAnchor, constant: 0),
            originatorLabel.trailingAnchor.constraint(equalTo: originatorAccountView.trailingAnchor, constant: 0),
            originatorAccountLabel.leadingAnchor.constraint(equalTo: originatorAccountView.leadingAnchor, constant: 0),
            originatorAccountLabel.topAnchor.constraint(equalTo: originatorLabel.bottomAnchor, constant: spacer.xxs),
            originatorAccountLabel.trailingAnchor.constraint(equalTo: originatorAccountView.trailingAnchor, constant: 0),
            originatorAccountLabel.bottomAnchor.constraint(equalTo: originatorAccountView.bottomAnchor, constant: 0)
        ])
    }
}
