//
//  QuickActionPopView.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/28.
//

import UIKit

final class QuickActionPopView: UIView {
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
    
    iconView.contentMode = .scaleAspectFit
    addSubview(iconView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    iconView.frame = CGRect(x: 0, y: 0, width: bounds.width / 2.0, height: bounds.width / 2.0)
    iconView.center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
  }
  
  internal func configure(tintColor: UIColor) {
    self.tintColor = tintColor
  }
  
  internal func configure(image: UIImage?) {
    iconView.image = image
  }
  
  internal func presentColor() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.backgroundColor = self?.tintColor
      self?.iconView.tintColor = UIColor.white
    }
  }
  
  internal func dismissColor() {
    UIView.animate(withDuration: 0.3) { [weak self] in
      self?.backgroundColor = UIColor.white
      self?.iconView.tintColor = self?.tintColor
    }
  }
}
