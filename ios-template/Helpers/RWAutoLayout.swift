///// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import UIKit

// swiftlint:disable function_parameter_count
// MARK: NSLayoutConstraint Convenience methods
extension NSLayoutConstraint {
  
  // Pins an attribute of a view to an attribute of another view
  static func pinning(view: UIView, attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: toAttribute, multiplier: multiplier, constant: constant)
  }
  
  // Pins an array of NSLayoutAttributes of a view to a specific view (has to respect view tree hierarchy)
  static func pinning(view: UIView, toView: UIView?, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
    return attributes.compactMap({ (attribute) -> NSLayoutConstraint in
      return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: multiplier, constant: constant)
    })
  }
  
  // Pins bottom, top, leading and trailing of a view to a specific view (has to respect view tree hierarchy)
  static func pinningEdges(view: UIView, toView: UIView?) -> [NSLayoutConstraint] {
    let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
    return NSLayoutConstraint.pinning(view: view, toView: toView, attributes: attributes, multiplier: 1.0, constant: 1.0)
  }
  
  // Pins bottom, top, leading and trailing of a view to its superview
  static func pinningEdgesToSuperview(view: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.pinningEdges(view: view, toView: view.superview)
  }
  
  // Pins specified attribute to superview with specified or default multiplier and constant
  static func pinningToSuperview(view: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.pinning(view: view, toView: view.superview, attributes: attributes, multiplier: multiplier, constant: constant)
  }
}

// MARK: UIView Convenience methods
extension UIView {
  
  /// Pin Edges of View to it's Superview
  func pinEdgesToSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
    let constraints = NSLayoutConstraint.pinningToSuperview(view: self, attributes: attributes, multiplier: 1, constant: 0)
    superview.addConstraints(constraints)
  }
  
  /// Pin certain attributes to superView
  /// - Parameters:
  ///   - attributes: Layout Attributes
  ///   - multiplier: Multiplier
  ///   - constant: Constant
  func pinToSuperview(forAtrributes attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraints = NSLayoutConstraint.pinningToSuperview(view: self, attributes: attributes, multiplier: multiplier, constant: constant)
    superview.addConstraints(constraints)
  }
  
  /// Pin certain layout properties to particular view
  /// - Parameters:
  ///   - toView: The View to pin to
  ///   - attributes: Attributes
  ///   - multiplier: Multiplier
  ///   - constant: Constant
  func pin(toView: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraints = NSLayoutConstraint.pinning(view: self, toView: toView, attributes: attributes, multiplier: multiplier, constant: constant)
    superview.addConstraints(constraints)
  }
  
  /// Pin certain attributes to a View
  /// - Parameters:
  ///   - attribute: Attributes
  ///   - toView: View to pin to
  ///   - toAttribute: that View's attribute
  ///   - multiplier: Multiplier
  ///   - constant: Constant
  func pin(attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
    translatesAutoresizingMaskIntoConstraints = false
    guard let superview = self.superview else { return }
    let constraint = NSLayoutConstraint.pinning(view: self, attribute: attribute, toView: toView, toAttribute: toAttribute, multiplier: multiplier, constant: constant)
    superview.addConstraint(constraint)
  }
}
