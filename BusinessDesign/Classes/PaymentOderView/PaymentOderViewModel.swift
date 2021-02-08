//
//  Created by Backbase R&D B.V. on 6/30/20.
//

import UIKit

public struct PaymentOderViewModel {
    public var id: String
    var counterpartyName: String?
    var counterpartyTitle: String?
    var counterpartyAccountTitle: String?
    var counterpartyAccountNumber: String?
    var executionDate: String?
    var executionDateValue: String?
    var amount: String?
    var originatorName: String?
    var originatorAccount: String?
    var occurs: String?
    var occursValue: String?
    var executionDateStackViewSpacing: CGFloat = 0
    var counterpartyAccountStackViewSpacing: CGFloat = 0

    public init(
        id: String,
        counterpartyName: String?,
        counterpartyTitle: String?,
        counterpartyAccountTitle: String?,
        counterpartyAccountNumber: String?,
        executionDate: String?,
        executionDateValue: String?,
        amount: String?,
        originator: String?,
        originatorAccount: String?,
        occurs: String?,
        occursValue: String?,
        executionDateStackViewSpacing: CGFloat,
        counterpartyAccountStackViewSpacing: CGFloat
    ) {
        self.id = id
        self.counterpartyName = counterpartyName
        self.counterpartyTitle = counterpartyTitle
        self.counterpartyAccountTitle = counterpartyAccountTitle
        self.counterpartyAccountNumber = counterpartyAccountNumber
        self.executionDate = executionDate
        self.executionDateValue = executionDateValue
        self.amount = amount
        self.originatorName = originator
        self.originatorAccount = originatorAccount
        self.occurs = occurs
        self.occursValue = occursValue
        self.executionDateStackViewSpacing = executionDateStackViewSpacing
        self.counterpartyAccountStackViewSpacing = executionDateStackViewSpacing
    }
}
