//
//  EditGeneralInfoViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/28/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class EditGeneralInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EditGeneralInfoTableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var tableView: UITableView!
    let imagePicker = UIImagePickerController()
    var selectedImage : UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kGeneralInfoCell) as EditGeneralInfoTableViewCell
        cell.delegate = self
        cell.firstNameTextField.text = kProfile?.firstName
        cell.lastNameTextField.text = kProfile?.lastName
        cell.emailTextField.text = kProfile?.user.username
        cell.profileImageView.file = kProfile?.imageFile
        cell.profileImageView.loadInBackground(nil)

        if let someImage = selectedImage
        {
            cell.profileImageView.image = someImage
        }

        return cell
    }

    @IBAction func onSaveButtonTapped(sender: UIBarButtonItem) {

        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as EditGeneralInfoTableViewCell!

        kProfile?.firstName = cell.firstNameTextField.text
        kProfile?.lastName = cell.lastNameTextField.text
        kProfile?.user.username = cell.emailTextField.text

        if let someImage = selectedImage
        {
            let imageData = UIImagePNGRepresentation(someImage)
            kProfile?.imageFile = PFFile(data: imageData)
        }

        kProfile?.saveInBackgroundWithBlock(nil)
        navigationController?.popViewControllerAnimated(true)
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
            self.tableView.reloadData()
        })
    }
}
