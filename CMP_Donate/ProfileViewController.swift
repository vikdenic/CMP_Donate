//
//  ProfileViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

//TODO: Safen user profile after registration (if no profile data, currently crashes)

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = kProfile?.firstName
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kProfileCell) as ProfileTableViewCell
            cell.profilePicImageView.file = kProfile?.imageFile
            cell.profilePicImageView.loadInBackground(nil)
            cell.clipsToBounds = true
            cell.coverPhotoImageView.clipsToBounds = true
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kFundedFilmCell) as FundedFilmTableViewCell
            let film = kProfile?.fundedFilms[indexPath.row - 1]
            cell.filmImageView.file = film?.imageFile
            cell.filmImageView.loadInBackground(nil)
            cell.filmTitleLabel.text = film?.title
            cell.clipsToBounds = true
            cell.filmImageView.clipsToBounds = true
            return cell
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return kProfile!.fundedFilms.count + 1
    }
}
