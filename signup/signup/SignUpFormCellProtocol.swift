//
//  SignUpFormCellProtocol.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 30/03/22.
//

import UIKit

protocol SignUpFormCellProtocol {
    static var bundle: Bundle? { get }
    static var nib: UINib? { get }
    static var nibName: String { get }
    static var reusableId: String { get }
}

extension SignUpFormCellProtocol where Self: UITableViewCell {
    static var bundle: Bundle? {
        return Bundle(for: Self.self)
    }
    static var nib: UINib? {
        return UINib(nibName: nibName, bundle: bundle)
    }
    static var nibName: String {
        return String(describing: self)
    }
    static var reusableId: String {
        return String(describing: self)
    }
}

extension UITableViewCell: SignUpFormCellProtocol{}

extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.reusableId)
    }
}
