//
//  NonfullscreenPresenter+Types.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit

public enum TransitionType {
    case presentation
    case dismissal
}

public enum BackgroundStyle {
    case clear
    case color(_ color: UIColor)
    case blur(_ style: UIBlurEffect.Style)
}

/// Animation for a transition
public struct Animation {
    public var delay: TimeInterval = 0
    public var options: UIView.AnimationOptions = .curveEaseInOut
    public var springDamping: CGFloat = 1.0
    public var initialSpringVelocity: CGFloat = 1
    public var preparation: (() -> Void)?
    public var animations: () -> Void
    public var completion: ((Bool) -> Void)?

    public init(animations: @escaping () -> Void) {
        self.animations = animations
    }
}

public protocol NonfullscreenPresented: AnyObject {

    /// Get the `presentedViewController` frame
    /// - Parameter view: The view `presentedViewController.view` will contain in.
    ///  Can get right `safeAreaInsets` from it.
    func presentedFrame(inContainerView view: UIView) -> CGRect

    /// Configure the animation by these two functions
    func animationDuration(for transitionType: TransitionType) -> TimeInterval
    func animation(for transitionType: TransitionType) -> Animation

    /// Set the background style when presenting
    var backgroundStyle: BackgroundStyle { get }

    /// Default false, If true, make the backgroud of presented view controller tappable
    /// and dismiss presented view controller when tapped
    var backgroundTapToDismissEnabled: Bool { get }

}

/// Default implemention of `NonfullscreenPresented`
public extension NonfullscreenPresented where Self: UIViewController {

    func presentedFrame(inContainerView view: UIView) -> CGRect {
        view.frame
    }

    func animationDuration(for transitionType: TransitionType) -> TimeInterval {
        0.25
    }

    var backgroundStyle: BackgroundStyle {
        .clear
    }

    var backgroundTapToDismissEnabled: Bool { false }

}

public typealias NonfullscreenPresentedViewController = (UIViewController & NonfullscreenPresented)
