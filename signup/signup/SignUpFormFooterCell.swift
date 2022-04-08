//
//  SignUpFormFooterCell.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 31/03/22.
//

import UIKit

struct SignUpFooterItem: SignUpCellItemProtocol {
    var id: String = ""
    var cellId: String = SignUpFormFooterCell.reusableId
    var cancelTapCallback: (() -> Void)?
    var submitTapCallback: (() -> Void)?
}

class SignUpFormFooterCell: UITableViewCell {
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!

    var item: SignUpFooterItem? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        cancelBtn.setTitle("Cancel", for: .normal)
        submitBtn.setTitle("Submit", for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func cancelBtnTapped() {
        item?.cancelTapCallback?()
    }
    
    @IBAction func submitBtnTapped() {
        item?.submitTapCallback?()
    }
    
}
