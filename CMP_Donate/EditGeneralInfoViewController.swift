//
//  EditGeneralInfoViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/28/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class EditGeneralInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditGeneralInfoTableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    var selectedImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kGeneralInfoCell) as EditGeneralInfoTableViewCell
        cell.firstNameTextField.text = kProfile?.firstName
        cell.lastNameTextField.text = kProfile?.lastName
        cell.emailTextField.text = kProfile?.user.username
        cell.profileImageView.file = kProfile?.imageFile
        cell.profileImageView.loadInBackground(nil)
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }

    //EditGeneralInfoTableViewDelegate
    func didTapEditPhoto(passed: Bool)
    {
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    //ImagePicker
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            self.selectedImage = image
        })
    }
}
