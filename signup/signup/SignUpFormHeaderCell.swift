//
//  SignUpFormHeaderCell.swift
//  signup
//
//  Created by Mahesh Dhumpeti on 01/04/22.
//

import UIKit

struct SignUpHeaderItem: SignUpCellItemProtocol {
    let header: String
    let caption: String
    var id: String = ""
    var cellId: String = SignUpFormHeaderCell.reusableId
}

class SignUpFormHeaderCell: UITableViewCell {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    var item: SignUpHeaderItem? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        guard let item = item else { return }
        headerLabel.text = item.header
        captionLabel.text = item.caption
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
