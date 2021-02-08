//
//  Created by Backbase R&D B.V. on 06/03/2020.
//

import UIKit
import UIScrollView_InfiniteScroll
import VGParallaxHeader

public enum BBTableHeaderType {
    case standard(view: UIView, height: CGFloat, backgroundColor: UIColor)
    case parallax(view: UIView, height: CGFloat, backgroundColor: UIColor)
}

public class BBTableView: UITableView {

    public var bbTableHeaderType: BBTableHeaderType? {
        didSet {
            guard let bbTableHeaderType = bbTableHeaderType else { return }
            configureHeaderView(with: bbTableHeaderType)
        }
    }

    weak var refreshControlDelegate: BBTableViewRefreshDelegate? {
        didSet {
            guard let delegate = refreshControlDelegate else { return }
            configureWithRefreshControl(delegate)
        }
    }

    weak var infiniteScrollingDelegate: BBTableViewInfiniteScrollingDelegate? {
        didSet {
            guard let delegate = infiniteScrollingDelegate else { return }
            configureWithInfiniteScrolling(delegate)
        }
    }

    convenience public init() {
        self.init(frame: .zero)

        configureWithDefaultStyle()
    }

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        configureWithDefaultStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureWithDefaultStyle()
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        configureWithDefaultStyle()
    }

    public func attachedTo(superview: UIView) {
        if self.isDescendant(of: superview) == false {
            superview.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leftAnchor.constraint(equalTo: superview.leftAnchor),
            rightAnchor.constraint(equalTo: superview.rightAnchor)
        ])
    }

    public func addTopBounceAreaView(color: UIColor = .white) {
        var frame = UIScreen.main.bounds
        frame.origin.y = -frame.size.height
        let view = UIView(frame: frame)
        view.backgroundColor = color
        addSubview(view)
    }
}

private extension BBTableView {
    func configureHeaderView(with headerView: BBTableHeaderType) {
        switch headerView {
        case .parallax(let view, let height, let backgroundColor):
            let parallaxContainerView = ParallaxContainerView(header: view, height: height)
            parallaxContainerView.backgroundColor = backgroundColor
            setParallaxHeader(parallaxContainerView, mode: .center, height: height)
        case .standard(let view, let height, let backgroundColor):
            var headerFrame: CGRect = .zero
            headerFrame.size.height = height
            let standardHeaderView = StandardTableHeaderContainerView(
                header: view,
                frame: headerFrame
            )
            standardHeaderView.backgroundColor = backgroundColor
            tableHeaderView = standardHeaderView
            tableHeaderView?.frame = headerFrame
        }
    }

    func configureWithDefaultStyle() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 48
        backgroundColor = OldDesignSystem.colors.white
        separatorStyle = .singleLine
        tableFooterView = UIView(frame: CGRect.zero)
        estimatedSectionHeaderHeight = 60
    }

    func configureWithRefreshControl(_ delegate: BBTableViewRefreshDelegate) {

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = OldDesignSystem.colors.white
        self.refreshControl = refreshControl
        refreshControl.addTarget(delegate, action: #selector(delegate.refreshData), for: .valueChanged)
        // Update the layer position in the superlayer to make sure the refresh control is above the parallax view
        refreshControl.layer.zPosition = 1
    }

    func configureWithInfiniteScrolling(_ delegate: BBTableViewInfiniteScrollingDelegate) {
        infiniteScrollTriggerOffset = 200

        addInfiniteScroll { [weak self] (_) -> Void in
            guard let `self` = self else { return }
            if self.infiniteScrollingDelegate?.canLoadMore() ?? false {
                self.infiniteScrollingDelegate?.fetchMore(resettingPagination: false)
            } else {
                self.finishInfiniteScroll()
                self.removeInfiniteScroll()
            }
        }
    }
}

@objc protocol BBTableViewRefreshDelegate {
    func refreshData()
}

@objc protocol BBTableViewInfiniteScrollingDelegate {
    func canLoadMore() -> Bool
    func fetchMore(resettingPagination: Bool)
}
