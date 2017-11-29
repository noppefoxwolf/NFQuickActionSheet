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
  private var vc: QuickActionController? = nil
  @IBOutlet weak var a: UIImageView!
  @IBOutlet weak var b: UIImageView!
  @IBOutlet weak var c: UIImageView!
  @IBOutlet weak var d: UIImageView!
  @IBOutlet weak var e: UIImageView!
  @IBOutlet weak var f: UIImageView!
  @IBOutlet weak var g: UIImageView!
  @IBOutlet weak var h: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    [a,b,c,d,e,f,g,h].forEach {
      let longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPressAction))
      longPress.minimumPressDuration = 0.2
      $0?.isUserInteractionEnabled = true
      $0?.addGestureRecognizer(longPress)
    }
  }
  
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
}

