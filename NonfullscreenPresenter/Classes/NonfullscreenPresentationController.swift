//
//  NonfullscreenPresentationController.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit

class NonfullscreenPresentationController: UIPresentationController {

    var backgroundTapToDismissEnabled: Bool
    weak var nonfullscreenPresenter: NonfullscreenPresenter?

    var backgroundStyle: BackgroundStyle

    var blurView: UIVisualEffectView?

    /// `UIVisualEffectView` is not animatale in some iOS version, so add it to an `UIView`
    lazy var blurBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        if self.backgroundTapToDismissEnabled {
            let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
            view.addGestureRecognizer(tap)
        }
        return view
    }()

    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         backgroundStyle: BackgroundStyle,
         backgroundTapToDismissEnabled: Bool = false) {
        self.backgroundStyle = backgroundStyle
        self.backgroundTapToDismissEnabled = backgroundTapToDismissEnabled
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        blurBackgroundView.alpha = 0

        switch backgroundStyle {
        case .color(let color):
            blurBackgroundView.backgroundColor = color
        case .blur(let style):
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
            blurBackgroundView.addSubview(blurView)
            self.blurView = blurView
        default:
            break
        }
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        blurBackgroundView.frame = containerView.bounds
        containerView.insertSubview(blurBackgroundView, at: 0)

        blurBackgroundView.alpha = 0.0

        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.blurBackgroundView.alpha = 1.0
            }, completion: nil)
        } else {
            self.blurBackgroundView.alpha = 1.0
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.blurBackgroundView.alpha = 0.0
            }, completion: nil)
        } else {
            self.blurBackgroundView.alpha = 0.0
        }
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            /// Otherwise `nonfullscreenPresenter` and `presentedViewController` will be retained until `presentingViewController` is dealloced
            self.presentingViewController.np.nonfullscreenPresenter = nil
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        return nonfullscreenPresenter?.presentedViewController.presentedFrame(inContainerView: containerView) ?? .zero
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else { return }

        blurBackgroundView.frame = containerView.bounds
        blurView?.frame = blurBackgroundView.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    @objc func backgroundTapped(_ sender: Any) {
        if self.backgroundTapToDismissEnabled {
            presentedViewController.dismiss(animated: true, completion: nil)
        }
    }

}
