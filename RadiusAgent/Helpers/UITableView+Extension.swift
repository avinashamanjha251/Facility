//
//  UITableView+Extension.swift
//  RadiusAgent
//
//  Created by Avinash Aman on 29/06/23.
//

import Foundation
import UIKit

typealias TableDelegate = UITableViewDelegate & UITableViewDataSource

extension UITableView {
    
    ///Dequeue Table View Cell
    func dequeueCell <T: UITableViewCell> (with identifier: T.Type) -> T {
        return self.dequeueReusableCell(withIdentifier: "\(identifier.self)") as! T
    }
    
    ///Register Table View Cell Nib
    func registerCell(with identifier: UITableViewCell.Type)  {
        self.register(UINib(nibName: "\(identifier.self)",bundle:nil),
                      forCellReuseIdentifier: "\(identifier.self)")
    }
    
}

extension UITableViewCell {
        
    var setSelectionStyleNone: UITableViewCell {
        self.selectionStyle = .none
        return self
    }
    
    var selectionColor: UIColor {
        set {
            let view = UIView()
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
        get {
            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
        }
    }
    
    var contentViewBackgroundColor: UIColor? {
        set {
            self.contentView.backgroundColor = newValue
        }
        get {
            self.contentView.backgroundColor
        }
    }
}

extension UITableView {
    
    func setEmptyMessage(_ message: String,
                         textColor: UIColor = .white) {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: self.bounds.size.width,
                                                 height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    
}
