//
//  QuickActionPopView.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/28.
//

import UIKit

class QuickActionPopView: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = UIColor.white
    layer.maskedCorners = [.layerMaxXMaxYCorner,
                           .layerMaxXMinYCorner,
                           .layerMinXMaxYCorner,
                           .layerMinXMinYCorner]
    layer.cornerRadius = frame.width / 2.0
    layer.masksToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
