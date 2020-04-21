//
//  ActionSheetViewController.swift
//
//  Created by Chen Qizhi on 2020/04/21.
//

import UIKit
import NonfullscreenPresenter

class ActionSheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}

extension ActionSheetViewController: NonfullscreenPresented {

    func presentedFrame(inContainerView view: UIView) -> CGRect {
        return CGRect(x: 10, y: view.frame.height - 310 - view.safeAreaInsets.bottom, width: view.frame.width - 20, height: 300)
    }

    func animation(for transitionType: TransitionType) -> Animation {
        var animation = Animation {
            self.view.alpha = (transitionType == .presentation) ? 1.0 : 0.0
        }

        if transitionType == .presentation {
            animation.preparation = {
                self.view.alpha = 0.0
            }
        }

        return animation
    }

    var backgroundStyle: BackgroundStyle { .color(UIColor(white: 0, alpha: 0.3)) }

    var backgroundTapToDismissEnabled: Bool { true }

}
