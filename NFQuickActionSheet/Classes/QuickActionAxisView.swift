//
//  QuickActionAxisView.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/28.
//

import UIKit

final class QuickActionAxisView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.maskedCorners = [.layerMaxXMaxYCorner,
                           .layerMaxXMinYCorner,
                           .layerMinXMaxYCorner,
                           .layerMinXMinYCorner]
    layer.cornerRadius = frame.width / 2.0
    layer.masksToBounds = true
    layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
    layer.borderWidth = 4.0
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
