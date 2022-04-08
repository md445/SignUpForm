//
//  SignUpFormSubHeaderCell.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 01/04/22.
//

import UIKit

struct SignUpSubHeaderItem: SignUpCellItemProtocol {
    let subHeader: String
    var id: String = ""
    var cellId: String = SignUpFormSubHeaderCell.reusableId
}

class SignUpFormSubHeaderCell: UITableViewCell {

    @IBOutlet weak var subHeaderLabel: UILabel!

    var item: SignUpSubHeaderItem? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        guard let item = item else { return }
        subHeaderLabel.text = item.subHeader
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
