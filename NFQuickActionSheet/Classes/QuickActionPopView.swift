//
//  QuickActionPopView.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/28.
//

import UIKit

class QuickActionPopView: UIView {
  private let bgView = UIView()
  private let iconView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    layer.maskedCorners = [.layerMaxXMaxYCorner,
                           .layerMaxXMinYCorner,
                           .layerMinXMaxYCorner,
                           .layerMinXMinYCorner]
    layer.cornerRadius = frame.width / 2.0
    layer.masksToBounds = true
    
    bgView.alpha = 0.0
    iconView.contentMode = .scaleAspectFit
    addSubview(bgView)
    addSubview(iconView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    bgView.frame = bounds
    iconView.frame = CGRect(x: 0, y: 0, width: bounds.width / 2.0, height: bounds.width / 2.0)
    iconView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
  }
  
  internal func configure(tintColor: UIColor) {
    bgView.backgroundColor = tintColor
  }
  
  internal func configure(image: UIImage?) {
    iconView.image = image
  }
  
  internal func presentColor() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.bgView.alpha = 1.0
    }
  }
  
  internal func dismissColor() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.bgView.alpha = 0.0
    }
  }
}
