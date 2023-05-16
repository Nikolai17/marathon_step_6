//
//  ViewController.swift
//  step6
//
//  Created by Nikolay Volnikov on 16.05.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Private properties

    private lazy var button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        button.configuration = config
        button.layer.cornerRadius = 10
        button.layer.cornerCurve = .continuous

        return button
    }()

    private var collision: UICollisionBehavior!
    private var snap: UISnapBehavior!
    private var animator: UIDynamicAnimator!

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))

        view.isUserInteractionEnabled = true
        view.addSubview(button)
        view.addGestureRecognizer(tap)
        button.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.size.equalTo(100)
            $0.leading.equalToSuperview().offset(100)
        }
    }
}

// MARK: - Private methods

fileprivate extension ViewController {

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        animateMove(sender.location(in: self.view))
    }

    func animateMove(_ point: CGPoint) {
        animator.removeAllBehaviors()

        collision = UICollisionBehavior(items: [button])
        collision.translatesReferenceBoundsIntoBoundary = true

        animator.addBehavior(collision)

        snap = UISnapBehavior(item: button, snapTo: point)
        snap.damping = 1
        animator.addBehavior(snap)
        button.snp.remakeConstraints {
            $0.size.equalTo(100)
            $0.center.equalTo(point)
        }

        view.layoutSubviews()
    }
}
