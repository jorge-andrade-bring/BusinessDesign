//
//  Created by Backbase R&D B.V. on 21/01/2020.
//

import Foundation

public enum IconStyle {
    case accountBalanceWallet
    case accountBalance
    case addBox
    case add
    case apps
    case arrowBack
    case arrowDropDown
    case callMade
    case callReceiving
    case cancel
    case checkCircle
    case check
    case chevronLeft
    case chevronRight
    case close
    case creditCard
    case delete
    case domain
    case donutSmall
    case downArrow
    case draft
    case email
    case error
    case errorOutline
    case exitToApp
    case gavel
    case inbox
    case infoOutline
    case info
    case language
    case loading
    case localAtm
    case lock
    case loop
    case longArrow
    case message
    case notification
    case removeCircleOutline
    case search
    case swapHoriz
    case starBorder
    case star
    case timer
    case trendingUp
    case warning
    case moreHoriz
    case highlightOff
    case checkBox
    case checkBoxOutlineBlank
    case barChart
    case warningOutline
    case wifiSignalLost
    case today
    case watch
    case `repeat`
    case identity
    case addPerson
    case expandMore
}

public extension IconStyle {

    /// Convenience getter that maps the `IconStyle` with the `IconsConfiguration` and
    /// returns the respective tuple value that contains the image resource
    var imageLocator: IconLocator {
        let allIcons = OldDesignSystem.icons
        switch self {
        case .accountBalanceWallet: return allIcons.accountBalanceWallet
        case .accountBalance: return allIcons.accountBalance
        case .addBox: return allIcons.addBox
        case .add: return allIcons.add
        case .apps: return allIcons.apps
        case .arrowBack: return allIcons.arrowBack
        case .arrowDropDown: return allIcons.arrowDropDown
        case .callMade: return allIcons.callMade
        case .callReceiving: return allIcons.callReceiving
        case .cancel: return allIcons.cancel
        case .checkCircle: return allIcons.checkCircle
        case .check: return allIcons.check
        case .chevronLeft: return allIcons.chevronLeft
        case .chevronRight: return allIcons.chevronRight
        case .close: return allIcons.close
        case .creditCard: return allIcons.creditCard
        case .delete: return allIcons.delete
        case .domain: return allIcons.domain
        case .donutSmall: return allIcons.donutSmall
        case .downArrow: return allIcons.downArrow
        case .draft: return allIcons.draft
        case .email: return allIcons.email
        case .error: return allIcons.error
        case .errorOutline: return allIcons.errorOutline
        case .exitToApp: return allIcons.exitToApp
        case .gavel: return allIcons.gavel
        case .infoOutline: return allIcons.infoOutline
        case .inbox: return allIcons.inbox
        case .info: return allIcons.info
        case .language: return allIcons.language
        case .loading: return allIcons.loading
        case .localAtm: return allIcons.localAtm
        case .lock: return allIcons.lock
        case .loop: return allIcons.loop
        case .longArrow: return allIcons.longArrow
        case .message: return allIcons.message
        case .notification: return allIcons.notification
        case .removeCircleOutline: return allIcons.removeCircleOutline
        case .search: return allIcons.search
        case .swapHoriz: return allIcons.swapHoriz
        case .starBorder: return allIcons.starBorder
        case .star: return allIcons.star
        case .timer: return allIcons.timer
        case .trendingUp: return allIcons.trendingUp
        case .warning: return allIcons.warning
        case .moreHoriz: return allIcons.moreHoriz
        case .highlightOff: return allIcons.highlightOff
        case .checkBox: return allIcons.checkBox
        case .checkBoxOutlineBlank: return allIcons.checkBoxOutlineBlank
        case .barChart: return allIcons.barChart
        case .warningOutline: return allIcons.warningOutline
        case .wifiSignalLost: return allIcons.wifiSignalLost
        case .today: return allIcons.today
        case .watch: return allIcons.watch
        case .repeat: return allIcons.repeat
        case .identity: return allIcons.identity
        case .addPerson: return allIcons.addPerson
        case .expandMore: return allIcons.expandMore
        }
    }
}
