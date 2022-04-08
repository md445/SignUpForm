//
//  SignUpFormTextFieldCell.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 30/03/22.
//

import UIKit

class SignUpTextFieldItem: SignUpCellItemProtocol, SignUpCellItemValueRequiredProtocol {
    let placeholder: String
    let error: String
    let type: SignUpTextFieldItem.FieldType
    var id: String
    var cellId: String
    var isValueRequired: Bool
    let valueCompletion: (SignUpTextFieldItem, String?) -> Void
    let isValueValid: (SignUpTextFieldItem) -> Bool

    var pickerTapCallback: ((SignUpTextFieldItem) -> Void)?
    var value: String?
    
    init(placeholder: String,
         error: String,
         type: SignUpTextFieldItem.FieldType,
         id: String,
         cellId: String,
         isValueRequired: Bool,
         valueCompletion: @escaping (SignUpTextFieldItem, String?) -> Void,
         isValueValid: @escaping (SignUpTextFieldItem) -> Bool) {
        self.placeholder = placeholder
        self.error = error
        self.type = type
        self.id = id
        self.cellId = cellId
        self.isValueRequired = isValueRequired
        self.valueCompletion = valueCompletion
        self.isValueValid = isValueValid
    }
    
    enum FieldType {
        case firstname, middlename, lastname, addressLine1, addressLine2, city, state, zip, phone, email, confirmEmail, dob, gender
        
        var isOptional: Bool {
            switch self {
            case .middlename, .addressLine2: return true
            default: return false
            }
        }
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .firstname, .middlename, .lastname,.addressLine1, .addressLine2,.city, .state, .dob, .gender:
                return UIKeyboardType.default
            case .zip:
                return UIKeyboardType.numberPad
            case .phone:
                return UIKeyboardType.phonePad
            case .email:
                return UIKeyboardType.emailAddress
            case .confirmEmail:
                return UIKeyboardType.emailAddress
            }
        }
    }
    
    static func build(placeholder: String,
                      error: String,
                      type: SignUpTextFieldItem.FieldType,
                      id: String,
                      cellId: String = SignUpFormTextFieldCell.reusableId,
                      isValueRequired: Bool = true,
                      valueCompletion: @escaping (SignUpTextFieldItem, String?) -> Void,
                      isValueValid: @escaping (SignUpTextFieldItem) -> Bool) -> SignUpTextFieldItem {
        return SignUpTextFieldItem(placeholder: placeholder,
                                   error: error,
                                   type: type,
                                   id: id,
                                   cellId: cellId,
                                   isValueRequired: isValueRequired,
                                   valueCompletion: valueCompletion,
                                   isValueValid: isValueValid)
    }
    
}

class SignUpFormTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    private let provider = PickerDataProvider()
    
    var item: SignUpTextFieldItem? {
        didSet {
            configureUI()
        }
    }
    
    var allowedToValidateValue: Bool = false {
        didSet {
            guard let item = item, allowedToValidateValue else {
                errorLabel.text = nil
                return
            }
            if item.isValueValid(item) {
                errorLabel.text = nil
            } else {
                errorLabel.text = item.error
            }
        }
    }
    
    lazy var pickerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "down_b_arrow_icon"), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(pickerIconTapped), for: .touchUpInside)
        return btn
    }()
    
    private func configureUI() {
        guard let item = item else { return }
        
        textField.keyboardType = item.type.keyboardType
        textField.placeholder = item.placeholder
        textField.text = item.value
        
        if isPickerEnabled() {
            textField.rightView = pickerBtn
            textField.rightViewMode = .always
        } else {
            textField.rightView = nil
            textField.rightViewMode = .never
        }
        
        textField.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 8, height: 0)))
        textField.leftViewMode = .always
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    private func pickerIconTapped() {
        guard let item = item else { return }
        item.pickerTapCallback?(item)
    }
    
    private func isPickerEnabled() -> Bool {
        if let item = item, provider[item.type].count > 0 {
            return true
        }
        return false
    }
    
    @IBAction func textChanged() {
        guard let item = item else { return }
        item.valueCompletion(item, textField.text)
    }
    
}

extension SignUpFormTextFieldCell: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return !isPickerEnabled()
    }

}
