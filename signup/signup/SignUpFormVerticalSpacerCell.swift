//
//  SignUpFormVerticalSpacerCell.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 01/04/22.
//

import UIKit

struct SignUpVerticalSpacerItem: SignUpCellItemProtocol {
    let height: CGFloat
    var id: String
    var cellId: String
    
    static func build(with height: CGFloat) -> SignUpVerticalSpacerItem {
        return SignUpVerticalSpacerItem(height: height,
                                        id: "",
                                        cellId: SignUpFormVerticalSpacerCell.reusableId)
    }
}

class SignUpFormVerticalSpacerCell: UITableViewCell {
    
    @IBOutlet weak var verticalHeightConstraint: NSLayoutConstraint!

    var item: SignUpVerticalSpacerItem? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        guard let item = item else { return }
        
        verticalHeightConstraint.constant = item.height
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
