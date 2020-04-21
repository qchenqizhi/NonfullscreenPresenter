//
//  NonfullscreenPresenter.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit

class NonfullscreenPresenter: NSObject {

    var transitionType: TransitionType = .presentation
    var backgroundStyle: BackgroundStyle = .clear
    var animationDuration: TimeInterval = 0.25
    var presentedViewController: NonfullscreenPresentedViewController

    init(_ presentedViewController: NonfullscreenPresentedViewController) {
        self.presentedViewController = presentedViewController
        super.init()
        self.presentedViewController.modalPresentationStyle = .custom
        self.presentedViewController.transitioningDelegate = self
    }

}

extension NonfullscreenPresenter: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .presentation
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionType = .dismissal
        return self
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let bgStyle = presentedViewController.backgroundStyle
        let tapEnabled = presentedViewController.backgroundTapToDismissEnabled
        let pc = NonfullscreenPresentationController(presentedViewController: presented,
                                                     presenting: presenting,
                                                     backgroundStyle: bgStyle,
                                                     backgroundTapToDismissEnabled: tapEnabled)
        pc.nonfullscreenPresenter = self
        return pc
    }

}

extension NonfullscreenPresenter: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration = presentedViewController.animationDuration(for: transitionType)
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animation = presentedViewController.animation(for: transitionType)

        guard
            let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to),
            let fromView = from.view,
            let toView = to.view
            else { return }

        if transitionType == .presentation {
            transitionContext.containerView.addSubview(toView)
        }

        animation.preparation?()

        UIView.animate(
            withDuration: animationDuration,
            delay: animation.delay,
            usingSpringWithDamping: animation.springDamping,
            initialSpringVelocity: animation.initialSpringVelocity,
            options: animation.options,
            animations: animation.animations,
            completion: { finished in
                animation.completion?(finished)
                if self.transitionType == .dismissal {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(finished)
        })
    }
}
