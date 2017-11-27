//
//  QuickAction.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/27.
//

import UIKit

public struct QuickAction {
  public let title: String
  public let color: UIColor
  public let image: UIImage?
  public let handler: ((QuickAction) -> Void)
  
  public init(title: String, color: UIColor = UIColor.red, image: UIImage?, handler: @escaping ((QuickAction) -> Void)) {
    self.title = title
    self.color = color
    self.image = image
    self.handler = handler
  }
}

