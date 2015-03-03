//
//  EditGeneralInfoTableViewCell.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/28/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

@objc protocol EditGeneralInfoTableViewDelegate
{
    optional func didTapEditPhoto(passed : Bool)
}

class EditGeneralInfoTableViewCell: UITableViewCell {

    var delegate = EditGeneralInfoTableViewDelegate?()

    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var profileImageView: PFImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        firstNameTextField.addBottomBorder()
        lastNameTextField.addBottomBorder()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onEditButtonTapped(sender: UIButton) {
        delegate?.didTapEditPhoto!(true)
    }
}
