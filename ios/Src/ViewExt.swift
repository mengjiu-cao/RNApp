//
//  ViewExt.swift
//  RNApp
//
//  Created by shutters on 2025/4/9.
//
import UIKit

extension UIImage
{
  func resizedImage(sizeImage: CGSize) -> UIImage?
  {
      let frame = CGRect(origin: CGPoint.zero, size: CGSize(width: sizeImage.width, height: sizeImage.height))
      UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
      self.draw(in: frame)
      let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      self.withRenderingMode(.alwaysOriginal)
      return resizedImage
  }
}
