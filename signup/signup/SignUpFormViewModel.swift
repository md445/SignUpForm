//
//  SignUpFormViewModel.swift
//  signup
//
//  Created by Itharaju, Naresh on 3/29/22.
//

import UIKit

protocol SignUpCellItemProtocol {
    var cellId: String {get set}
    var id: String {get set}
}

protocol SignUpCellItemValueRequiredProtocol {
    var isValueRequired: Bool {get set}
}

struct PickerDataProvider {
    
    private let dataStore: [SignUpTextFieldItem.FieldType: [String]] = [
        .state: ["Alabama", "Alaska", "Arizona", "California"],
        .dob : ["dob"],
        .gender: ["Male", "Female"]
    ]
    
    subscript(_ type: SignUpTextFieldItem.FieldType) -> [String] {
        return dataStore[type] ?? []
    }
}

protocol SignUpFormViewModelDelegate: AnyObject {
    func didTapCancel()
    func didTapSubmit()
}

class SignUpFormViewModel: NSObject {
    
    let reloadCallback: () -> Void

    init(reloadCallback: @escaping () -> Void,
         delegate: SignUpFormViewModelDelegate? = nil) {
        self.reloadCallback = reloadCallback
        self.delegate = delegate
    }
    
    weak var delegate: SignUpFormViewModelDelegate?
    
    private var fieldsDataCache: [String: String] = [:]
    
    private var beginValidation = false {
        didSet {
            reloadCallback()
        }
    }
    
    private var cellItems: [[SignUpCellItemProtocol]] = [] {
        didSet {
            reloadCallback()
        }
    }
        
    func loadData() {
        self.cellItems = prepareCellItems()
    }
    
    private func prepareCellItems() -> [[SignUpCellItemProtocol]] {
        var sections: [[SignUpCellItemProtocol]] = []
        
        // Header item
        sections.append(headerCellItems())
        
        // Contact Info
        sections.append(contactInfoCellItems())
        
        // Personal Info
        sections.append(personalInfoCellItems())
        
        // Footer buttons
        sections.append(footerCellItems())
        
        return sections
    }
    
    private func headerCellItems() -> [SignUpCellItemProtocol] {
        let item = SignUpHeaderItem(header: "Complete the form below to become an ExtraCare® member.",
                                    caption: "All fields required unless indicated.")
        return [item]
    }
    
    private func contactInfoCellItems() -> [SignUpCellItemProtocol] {
        var contactInfo: [SignUpCellItemProtocol] = []
        
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 20))
        
        let contactInfoSubHeaderItem = SignUpSubHeaderItem(subHeader: "Contact Info")
        contactInfo.append(contactInfoSubHeaderItem)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 16))

        let firstName = SignUpTextFieldItem.build(placeholder: "First Name",
                                                  error: "Please enter your first name",
                                                  type: SignUpTextFieldItem.FieldType.firstname,
                                                  id: "first_name")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        firstName.value = fieldsDataCache[firstName.id]
        contactInfo.append(firstName)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let middleName = SignUpTextFieldItem.build(placeholder: "Middle Initial (Optional)",
                                                   error: "Please enter your middle name",
                                                   type: SignUpTextFieldItem.FieldType.middlename,
                                                   id: "middle_name")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        middleName.value = fieldsDataCache[middleName.id]
        contactInfo.append(middleName)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let lastName = SignUpTextFieldItem.build(placeholder: "Last Name",
                                                 error: "Please enter your last name",
                                                 type: SignUpTextFieldItem.FieldType.lastname,
                                                 id: "last_name")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        lastName.value = fieldsDataCache[lastName.id]
        contactInfo.append(lastName)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let addressLine1 = SignUpTextFieldItem.build(placeholder: "Address Line 1",
                                                     error: "Please enter your address",
                                                     type: SignUpTextFieldItem.FieldType.addressLine1,
                                                     id: "address_line1")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        addressLine1.value = fieldsDataCache[addressLine1.id]
        contactInfo.append(addressLine1)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let addressLine2 = SignUpTextFieldItem.build(placeholder: "Address Line 2 (Optional)",
                                                     error: "",
                                                     type: SignUpTextFieldItem.FieldType.addressLine2,
                                                     id: "address_line2")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        addressLine2.value = fieldsDataCache[addressLine2.id]
        contactInfo.append(addressLine2)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let city = SignUpTextFieldItem.build(placeholder: "City",
                                             error: "Please enter your city",
                                             type: SignUpTextFieldItem.FieldType.city,
                                             id: "city")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        city.value = fieldsDataCache[city.id]
        contactInfo.append(city)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let state = SignUpTextFieldItem.build(placeholder: "State",
                                              error: "Please select a valid state",
                                              type: SignUpTextFieldItem.FieldType.state,
                                              id: "state")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        state.value = fieldsDataCache[state.id]
        contactInfo.append(state)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let zipCode = SignUpTextFieldItem.build(placeholder: "ZIP Code",
                                                error: "Please enter a valid zip code",
                                                type: SignUpTextFieldItem.FieldType.zip,
                                                id: "zip_code")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        zipCode.value = fieldsDataCache[zipCode.id]
        contactInfo.append(zipCode)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let phoneNum = SignUpTextFieldItem.build(placeholder: "Phone",
                                                 error: "Please enter a valid phone number",
                                                 type: SignUpTextFieldItem.FieldType.phone,
                                                 id: "phone_number")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        phoneNum.value = fieldsDataCache[phoneNum.id]
        contactInfo.append(phoneNum)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let emailAddress = SignUpTextFieldItem.build(placeholder: "Email Address",
                                                     error: "Please enter a valid email address",
                                                     type: SignUpTextFieldItem.FieldType.email,
                                                     id: "email_address")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        emailAddress.value = fieldsDataCache[emailAddress.id]
        contactInfo.append(emailAddress)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let confirmEmailAddress = SignUpTextFieldItem.build(placeholder: "Confirm Email Address",
                                                            error: "Please confirm email address",
                                                            type: SignUpTextFieldItem.FieldType.confirmEmail,
                                                            id: "confirm_email_address",
                                                            isValueRequired: false)
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty && value == emailAddress.value
        }
        confirmEmailAddress.value = fieldsDataCache[confirmEmailAddress.id]
        contactInfo.append(confirmEmailAddress)
        contactInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        return contactInfo
    }
    
    private func personalInfoCellItems() -> [SignUpCellItemProtocol] {
        var personalInfo: [SignUpCellItemProtocol] = []
        
        personalInfo.append(SignUpVerticalSpacerItem.build(with: 20))

        let personalInfoSubHeaderItem = SignUpSubHeaderItem(subHeader: "Personal Info")
        personalInfo.append(personalInfoSubHeaderItem)
        personalInfo.append(SignUpVerticalSpacerItem.build(with: 16))

        let dob = SignUpTextFieldItem.build(placeholder: "Date Of Birth",
                                            error: "Please enter date of birth",
                                            type: SignUpTextFieldItem.FieldType.dob,
                                            id: "dob")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        dob.value = fieldsDataCache[dob.id]
        personalInfo.append(dob)
        personalInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        let gender = SignUpTextFieldItem.build(placeholder: "Gender",
                                               error: "Please enter your gender",
                                               type: SignUpTextFieldItem.FieldType.gender,
                                               id: "gender")
        { [weak self] (item, value) in
            item.value = value
            self?.fieldsDataCache[item.id] = value
        } isValueValid: {
            if $0.type.isOptional { return true }
            guard let value = $0.value else { return false }
            return !value.isEmpty
        }
        gender.value = fieldsDataCache[gender.id]
        personalInfo.append(gender)
        personalInfo.append(SignUpVerticalSpacerItem.build(with: 8))

        return personalInfo
    }
    
    private func footerCellItems() -> [SignUpCellItemProtocol] {        
        var item = SignUpFooterItem()
        item.cancelTapCallback = handleCancelTap
        item.submitTapCallback = handleSubmitTap
        return [SignUpVerticalSpacerItem.build(with: 30),
                item,
                SignUpVerticalSpacerItem.build(with: 30)]
    }
    
    private func handlePickerTap(_ item: SignUpTextFieldItem) {
        print(item.type)
    }
    
    private func handleCancelTap() {
        delegate?.didTapCancel()
    }
    
    private func handleSubmitTap() {
        beginValidation = true

        var canSubmit = true
        for section in cellItems {
            for item in section {
                if let item = item as? SignUpTextFieldItem {
                    if !item.isValueValid(item) {
                        canSubmit = false
                        break
                    }
                }
            }
        }
        if canSubmit {
            print("Can submit")
        } else {
            print("Cannot submit")
        }
        delegate?.didTapSubmit()
    }
    
}

extension SignUpFormViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = cellItems[indexPath.section][indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellId) as? SignUpFormVerticalSpacerCell {
            cell.item = item as? SignUpVerticalSpacerItem
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellId) as? SignUpFormHeaderCell {
            cell.item = item as? SignUpHeaderItem
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellId) as? SignUpFormSubHeaderCell {
            cell.item = item as? SignUpSubHeaderItem
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellId) as? SignUpFormTextFieldCell {
            cell.item = item as? SignUpTextFieldItem
            cell.allowedToValidateValue = beginValidation
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.cellId) as? SignUpFormFooterCell {
            cell.item = item as? SignUpFooterItem
            return cell
        }
        return UITableViewCell()
    }
    
}
