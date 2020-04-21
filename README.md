# NonfullscreenPresenter

[![CI Status](https://img.shields.io/travis/qchenqizhi/NonfullscreenPresenter.svg?style=flat)](https://travis-ci.org/qchenqizhi/NonfullscreenPresenter)
[![Version](https://img.shields.io/cocoapods/v/NonfullscreenPresenter.svg?style=flat)](https://cocoapods.org/pods/NonfullscreenPresenter)
[![License](https://img.shields.io/cocoapods/l/NonfullscreenPresenter.svg?style=flat)](https://cocoapods.org/pods/NonfullscreenPresenter)
[![Platform](https://img.shields.io/cocoapods/p/NonfullscreenPresenter.svg?style=flat)](https://cocoapods.org/pods/NonfullscreenPresenter)

A lightweight wrapper for easily customizing animation of present non-fullscreen view controller

## Features

- [x] Customizing transition animation
- [x] Blured `presentingViewController`
- [x] Tap to dismiss
- [ ] Customizing push & pop
- [ ] Interacting present and dismiss with gesture

## Usage

1. Implement the protocol `NonfullscreenPresented` in `presentedViewController`:

	```swift
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
	```

2. Then use this function to present in `presentingViewController`:
	
	```swift
	self.np.present(alert)
	```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 11.4+
- Swift 5.2+
- iOS 11+

**Lower versions should work too, I just haven’t tried**

## Installation

NonfullscreenPresenter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NonfullscreenPresenter'
```

## Author

Chen Qizhi, qchenqizhi@gmail.com

## License

NonfullscreenPresenter is available under the MIT license. See the LICENSE file for more info.
