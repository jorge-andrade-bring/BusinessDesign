//
//  Created by Backbase R&D B.V. on 01/11/2019.
//

import Foundation
import UIKit

public class ModalController: UIViewController {

    var contentViewController: UIViewController

    public init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        add(contentViewController, to: view)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.title = contentViewController.navigationItem.title
        navigationItem.titleView = contentViewController.navigationItem.titleView
        navigationItem.rightBarButtonItems = contentViewController.navigationItem.rightBarButtonItems
    }

    @objc func close() {
        dismiss(animated: true, completion: nil)
    }

    private func add(_ child: UIViewController, to view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false

        let anchorContraints = [
            view.topAnchor.constraint(equalTo: child.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor),
            view.leftAnchor.constraint(equalTo: child.view.leftAnchor),
            view.rightAnchor.constraint(equalTo: child.view.rightAnchor)
        ]
        view.addConstraints(anchorContraints)
        view.layoutIfNeeded()
        child.didMove(toParent: self)
    }
}
