//
//  ProfileViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = kProfile?.name
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            let cell = tableView.dequeueReusableCellWithIdentifier(kProfileCell) as ProfileTableViewCell
            cell.profilePicImageView.file = kProfile?.imageFile
            cell.profilePicImageView.loadInBackground(nil)
            cell.clipsToBounds = true
            cell.coverPhotoImageView.clipsToBounds = true
            return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
}
