# NFQuickActionSheet

![](https://github.com/noppefoxwolf/NFQuickActionSheet/blob/master/Resource/sample.gif)

## Requirements

Swift 4.0
iOS 11.0

## Example

```
let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressAction))
longPress.minimumPressDuration = 0.2
button.addGestureRecognizer(longPress)
```

```
  @objc func longPressAction(_ sender: UILongPressGestureRecognizer) {
    switch sender.state {
    case .began:
      
      vc = QuickActionController.make(with: sender.view)
      vc?.addAction(
        QuickAction(title: "Camera", color: UIColor.lightGray, image: UIImage(named: "icons8-camera"), handler: { (_) in
          print("fav")
        })
      )
      vc?.addAction(
        QuickAction(title: "Favorite", color: UIColor.yellow, image: UIImage(named: "icons8-like"), handler: { (_) in
          print("rt")
        })
      )
      vc?.addAction(
        QuickAction(title: "Other", color: UIColor.darkGray, image: UIImage(named: "icons8-menu"), handler: { (_) in
          print("other")
        })
      )
      present(vc!, animated: true, completion: {
        self.vc?.gestureBegan(sender)
      })
    case .changed:
      vc?.gestureChanged(sender)
    case .ended:
      vc?.gestureEnded(sender)
    default: break
    }
  }
```

## Installation

```ruby
pod 'NFQuickActionSheet'
```

## Author

🦊Tomoya Hirano, noppelabs@gmail.com

## License

NFQuickActionSheet is available under the MIT license. See the LICENSE file for more info.
