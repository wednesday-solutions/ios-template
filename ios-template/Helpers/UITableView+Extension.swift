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

import UIKit

extension UITableView {
  
  func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
    let cellName = String(describing: cellClass)
    register(cellClass, forCellReuseIdentifier: cellName)
  }
  
  func registerNib<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
    let cellName = String(describing: cellClass)
    register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
  }
  
  func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
    let identifier = String(describing: Cell.self)
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
      fatalError("Error for cell id: \(identifier) at \(indexPath)")
    }
    return cell
  }
  
  func registerHeader<Header: UITableViewHeaderFooterView>(_ headerClass: Header.Type) {
    let headerName = String(describing: headerClass)
    register(headerClass, forHeaderFooterViewReuseIdentifier: headerName)
  }
  
  func registerHeaderNib<Header: UITableViewHeaderFooterView>(_ headerClass: Header.Type) {
    let nibName = String(describing: headerClass)
    let nib = UINib(nibName: nibName, bundle: nil)
    register(nib, forHeaderFooterViewReuseIdentifier: nibName)
  }
  
  func dequeueReusableHeader<Header: UITableViewHeaderFooterView>() -> Header {
    let identifier = String(describing: Header.self)
    guard let header = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? Header else {
      fatalError("Error for header id: \(identifier)")
    }
    return header
    
  }
  
}

class GenericTableViewCell<View: UIView>: UITableViewCell {
  var cellView: View? {
    didSet {
      guard cellView != nil else { return }
      setupViews()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    guard let cellView = cellView else { return }
    addSubview(cellView)
    
  }
}
