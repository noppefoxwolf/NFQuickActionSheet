//
//  ViewController.swift
//  NFQuickActionSheet
//
//  Created by 🦊Tomoya Hirano on 11/27/2017.
//  Copyright (c) 2017 🦊Tomoya Hirano. All rights reserved.
//

import UIKit
import NFQuickActionSheet

class ViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  private var vc: QuickActionController? = nil
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressAction))
    longPress.minimumPressDuration = 0.2
    imageView.addGestureRecognizer(longPress)
    imageView.isUserInteractionEnabled = true
  }
  
  @objc func longPressAction(_ sender: UILongPressGestureRecognizer) {
    switch sender.state {
    case .began:
      vc = QuickActionController.make(with: sender.view)
      vc?.addAction(
        QuickAction(title: "カメラ", color: UIColor.lightGray, image: UIImage(named: "icons8-camera"), handler: { (_) in
          print("fav")
        })
      )
      vc?.addAction(
        QuickAction(title: "お気に入り", color: UIColor.yellow, image: UIImage(named: "icons8-like"), handler: { (_) in
          print("rt")
        })
      )
      vc?.addAction(
        QuickAction(title: "その他", color: UIColor.darkGray, image: UIImage(named: "icons8-menu"), handler: { (_) in
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
}

