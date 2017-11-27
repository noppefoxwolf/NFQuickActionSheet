//
//  QuickActionControllerAnimator.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/27.
//

import UIKit

final class QuickActionControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  let kMovedDistance: CGFloat = 70.0 // 遷移元のviewのずれる分の距離
  let kDuration = 0.25
  var presenting = false // 遷移するときtrue（戻るときfalse）
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return presenting ? kDuration : kDuration / 2.0
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
    let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
    
    // 遷移するときと戻るときとで処理を変える
    if presenting {
      presentTransition(transitionContext: transitionContext, toView: toVC!.view, fromView: fromVC!.view)
    } else {
      dismissTransition(transitionContext: transitionContext, toView: toVC!.view, fromView: fromVC!.view)
    }
  }
  
  // 遷移するときのアニメーション
  func presentTransition(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView) {
    let containerView = transitionContext.containerView
    containerView.insertSubview(toView, aboveSubview: fromView) // toViewの下にfromView
    
    toView.frame = fromView.frame
    toView.alpha = 0.0
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext),
                   delay: 0.0,
                   options: .curveEaseInOut, animations: { () -> Void in
                    toView.alpha = 1.0
    }) { (finished) -> Void in
      toView.alpha = 1.0
      transitionContext.completeTransition(true)
    }
  }
  
  // 戻るときのアニメーション
  func dismissTransition(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView) {
    UIView.animate(withDuration: transitionDuration(using: transitionContext),
                   delay: 0,
                   options: .curveEaseInOut, animations: { () -> Void in
      fromView.alpha = 0.0
    }) { (finished) -> Void in
      transitionContext.completeTransition(true)
    }
    
  }
}

