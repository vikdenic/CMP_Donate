//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController {

    @IBOutlet var filmImageView: PFImageView!
    var film = Film()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI()
    {
        title = film.title
        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)
    }
}
