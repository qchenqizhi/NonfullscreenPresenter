//
//  UIViewController+NonfullscreenPresenter.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit

public class NonfullscreenPresenterWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol NonfullscreenPresenterCompatible: AnyObject {}

public extension NonfullscreenPresenterCompatible {
    var np: NonfullscreenPresenterWrapper<Self> {
        get { return NonfullscreenPresenterWrapper(self) }
        set {}
    }
}

extension UIViewController: NonfullscreenPresenterCompatible {}

public extension NonfullscreenPresenterWrapper where Base: UIViewController {

    /// Store presenter to avoid being released
    internal var nonfullscreenPresenter: NonfullscreenPresenter? {
        get {
            return objc_getAssociatedObject(base, &nonfullscreenPresenterKey) as? NonfullscreenPresenter
        }
        set {
            objc_setAssociatedObject(base, &nonfullscreenPresenterKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Present with custom `Nonfullscreen` animation
    func present(_ vc: NonfullscreenPresentedViewController, completion: (() -> Void)? = nil) {
        guard base.presentedViewController == nil else {
            print("Can not present twice in a view controller")
            return
        }
        let presenter = NonfullscreenPresenter(vc)
        nonfullscreenPresenter = presenter
        vc.modalPresentationStyle = .custom
        self.base.present(vc, animated: true, completion: completion)
    }

}

private var nonfullscreenPresenterKey: Void?
