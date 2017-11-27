//
//  QuickActionController.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/27.
//

import UIKit

public class QuickActionController: UIViewController, UIViewControllerTransitioningDelegate {
  private var actions = [QuickAction]()
  private var actionPops = [QuickActionPopView]()
  private var targetView: UIView!
  private lazy var spotLayer: CALayer = {
    let spotLayer = CALayer()
    spotLayer.frame = view.bounds
    spotLayer.backgroundColor = UIColor.white.cgColor
    spotLayer.opacity = 0.75
    let maskLayer = CAShapeLayer()
    maskLayer.frame = view.bounds
    maskLayer.fillRule = kCAFillRuleEvenOdd
    let maskFrame = targetView.convert(targetView.bounds, to: view)
    let path = UIBezierPath(roundedRect: maskFrame, cornerRadius: 4.0)
    path.append(UIBezierPath(rect: spotLayer.frame))
    maskLayer.path = path.cgPath
    spotLayer.mask = maskLayer
    return spotLayer
  }()
  
  private(set) var currentIndex: Int? = nil {
    willSet {
      if let newValue = newValue {
        if (currentIndex != nil && currentIndex != newValue) || (currentIndex == nil) {
          self.generator.selectionChanged()
        }
      }
      updateLabelText(index: newValue)
      updatePopsColor(index: newValue)
    }
  }
  
  private lazy var label: UILabel = {
    let label = UILabel()
    label.frame = CGRect(x: 0, y: 120, width: view.bounds.width, height: 120)
    label.font = UIFont.boldSystemFont(ofSize: 84)
    label.adjustsFontSizeToFitWidth = true
    label.textColor = UIColor.darkGray
    return label
  }()
  
  private var menuCenterPosition = CGPoint.zero
  private var popWidth: CGFloat = 54.0
  private let generator = UISelectionFeedbackGenerator()
  
  public static func make(with targetView: UIView?) -> QuickActionController {
    let vc = QuickActionController()
    vc.transitioningDelegate = vc
    vc.modalPresentationStyle = .overCurrentContext
    vc.targetView = targetView!
    vc.generator.prepare()
    return vc
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.clear
    addMaskLayer()
  }
  
  private func addMaskLayer() {
    view.layer.addSublayer(spotLayer)
  }
  
  public func addAction(_ action: QuickAction) {
    actions.append(action)
    
    let popView = QuickActionPopView(frame: CGRect(x: 0, y: 0, width: popWidth, height: popWidth))
    popView.configure(tintColor: action.color)
    popView.configure(image: action.image)
    actionPops.append(popView)
  }
  
  public func gestureBegan(_ sender: UIGestureRecognizer) {
    //軸
    menuCenterPosition = sender.location(in: view)
    setupCenterMenuIndicator()
    
    //views
    setupPops()
    animatePops()
    setupLabel()
    
    //taptic
    generator.selectionChanged()
  }
  
  private func setupCenterMenuIndicator() {
    let v = QuickActionAxisView(frame: CGRect(x: 0, y: 0, width: popWidth, height: popWidth))
    v.backgroundColor = UIColor.clear
    view.addSubview(v)
    v.center = menuCenterPosition
  }
  
  private func setupPops() {
    actionPops.forEach({
      self.view.addSubview($0)
      $0.center = self.menuCenterPosition
    })
  }
  
  private func setupLabel() {
    view.addSubview(label)
  }
  
  private func updateLabelText(index: Int?) {
    if let index = currentIndex {
      label.text = actions[index].title
    } else {
      label.text = nil
    }
  }
  
  public func gestureChanged(_ sender: UIGestureRecognizer) {
    let point = sender.location(in: view)
    currentIndex = index(of: point)
    animatePops()
  }
  
  public func gestureEnded(_ sender: UIGestureRecognizer) {
    let point = sender.location(in: view)
    if let index = index(of: point) {
      let action = actions[index]
      action.handler(action)
    }
    dismiss(animated: true, completion: nil)
  }
  
  private func index(of point: CGPoint) -> Int? {
    return actionPops.enumerated().flatMap({ (arg) -> Int? in
      let (index, _) = arg
      return self.touchableRect(index: index).contains(point) ? index : nil
    }).first
  }
  
  private func animatePops() {
    let after = { [weak self] in
      guard let _self = self else { return }
      _self.actionPops.enumerated().forEach { (index, view) in
        let isFocus = _self.currentIndex == index
        view.center = _self.popCenter(index: index, focus: isFocus)
        view.transform = isFocus ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
      }
    }
    UIView.animate(withDuration: 0.3,
                   delay: 0.0,
                   usingSpringWithDamping: 0.7,
                   initialSpringVelocity: 0.0,
                   options: .allowAnimatedContent,
                   animations: {
                    after()
    }) { (_) in
      
    }
  }
  
  private func updatePopsColor(index: Int?) {
    actionPops.enumerated().forEach { (offset, view) in
      if offset == index {
        view.presentColor()
      } else {
        view.dismissColor()
      }
    }
  }
  
  private func popCenter(index: Int, focus: Bool) -> CGPoint {
    let radOffset: CGFloat = 180.0 + 90.0 - 45.0
    let rad = CGFloat(index) * 45.0 + radOffset
    let r: CGFloat = focus ? 100.0 : 84.0
    let x = r * cos(rad * CGFloat.pi / 180)
    let y = r * sin(rad * CGFloat.pi / 180)
    let transform = CGAffineTransform(translationX: x, y: y)
    return menuCenterPosition.applying(transform)
  }
  
  private func touchableRect(index: Int) -> CGRect {
    let touchableWidth: CGFloat = 64.0
    let center = popCenter(index: index, focus: false)
    return CGRect(x: center.x - (touchableWidth / 2.0),
                  y: center.y - (touchableWidth / 2.0),
                  width: touchableWidth,
                  height: touchableWidth)
  }
 
  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = QuickActionControllerAnimator()
    animator.presenting = false
    return animator
  }
  
  public func animationController(forPresented presented: UIViewController,
                                  presenting: UIViewController,
                                  source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    let animator = QuickActionControllerAnimator()
    animator.presenting = true
    return animator
  }
}
