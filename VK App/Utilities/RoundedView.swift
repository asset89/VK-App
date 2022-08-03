//
//  RoundedView.swift
//  VK App
//
//  Created by Asset Ryskul on 22.12.2021.
//

import UIKit

class RoundedView: UIImageView {
    var cornerRadius: CGFloat {
      get {
        return layer.cornerRadius
      }
      set {
        layer.cornerRadius = 12.0
      }
    }
}
