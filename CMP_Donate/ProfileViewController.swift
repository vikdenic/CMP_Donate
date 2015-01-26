//
//  ProfileViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    @IBOutlet var profileImageView: PFImageView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setProfileData()
    }

    func setProfileData()
    {
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true

        navigationItem.title = kProfile?.name

        profileImageView.image = UIImage(named: "crewMemberImage")
        profileImageView.file = kProfile?.imageFile
        profileImageView.loadInBackground(nil)
    }
}
