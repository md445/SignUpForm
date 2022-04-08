//
//  SignUpFormViewController.swift
//  signup
//
//  Created by Itharaju, Naresh on 3/29/22.
//

import UIKit

class SignUpFormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = SignUpFormViewModel(reloadCallback: { [weak self] in
        self?.tableView.reloadData()
    }, delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .lightGray
        
        registerCells()
        setupKeyboardNotifications()
        
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        
        viewModel.loadData()
    }
    
    private func registerCells() {
        tableView.registerNib(SignUpFormVerticalSpacerCell.self)
        tableView.registerNib(SignUpFormHeaderCell.self)
        tableView.registerNib(SignUpFormSubHeaderCell.self)
        tableView.registerNib(SignUpFormTextFieldCell.self)
        tableView.registerNib(SignUpFormFooterCell.self)
    }
    
    private func setupKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset
    }

}

extension SignUpFormViewController: SignUpFormViewModelDelegate {
    
    func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapSubmit() {
    }
    
}
