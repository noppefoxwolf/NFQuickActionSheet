//
//  QuickAction.swift
//  NFQuickActionSheet
//
//  Created by Tomoya Hirano on 2017/11/27.
//

import UIKit

public struct QuickAction {
  public let title: String
  public let handler: ((QuickAction) -> Void)
  
  public init(title: String, handler: @escaping ((QuickAction) -> Void)) {
    self.title = title
    self.handler = handler
  }
}

