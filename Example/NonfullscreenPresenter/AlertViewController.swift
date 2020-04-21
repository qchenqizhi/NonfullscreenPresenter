//
//  AlertViewController.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit
import NonfullscreenPresenter

class PassthroughView: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}

class AlertViewController: UIViewController {

    override func loadView() {
        view = PassthroughView()
    }

    var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        view.addSubview(contentView)

        contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

        contentView.translatesAutoresizingMaskIntoConstraints = false

        contentView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension AlertViewController: NonfullscreenPresented {

    func presentedFrame(inContainerView view: UIView) -> CGRect {
        return view.frame
    }

    func animation(for transitionType: TransitionType) -> Animation {
        let animation = Animation(animations: {
            if transitionType == .presentation {
                self.contentView.transform = .identity
            } else {
                self.contentView.alpha = 0
                self.contentView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }
        })

        return animation
    }

    var backgroundStyle: BackgroundStyle { .blur(.dark) }

    var backgroundTapToDismissEnabled: Bool { true }

}
