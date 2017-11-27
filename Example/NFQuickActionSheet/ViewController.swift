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
        QuickAction(title: "お気に入り", handler: { (_) in
          
        })
      )
      vc?.addAction(
        QuickAction(title: "リツイート", handler: { (_) in
          
        })
      )
      vc?.addAction(
        QuickAction(title: "その他", handler: { (_) in
          
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

